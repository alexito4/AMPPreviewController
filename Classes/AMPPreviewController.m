// Copyright (c) 2014 Alejandro Martinez
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <AFNetworking/AFNetworking.h>

#import "AMPPreviewController.h"

#pragma mark - AMPPreviewItem

@interface AMPPreviewObject : NSObject <AMPPreviewItem>
@property (nonatomic, strong) NSURL *remoteUrl;
@property (nonatomic, strong, readwrite) NSURL *previewItemURL;
@property (nonatomic, strong, readwrite) NSString *previewItemTitle;
@end

@implementation AMPPreviewObject
@synthesize remoteUrl, previewItemURL, previewItemTitle;

@end

#pragma mark - AMPPreviewController

@interface AMPPreviewController () <QLPreviewControllerDataSource>

@property (nonatomic, strong) id <QLPreviewItem> previewItem;

@end

@implementation AMPPreviewController

- (id)initWithPreviewItem:(id<QLPreviewItem>)item {
    self = [self init];
    if (self) {
        _previewItem = item;
    }
    return self;
}

- (id)initWithFilePath:(NSURL *)filePath {
    self = [self init];
    if (self) {
        AMPPreviewObject *item = [AMPPreviewObject new];
        item.previewItemTitle = filePath.lastPathComponent;
        item.previewItemURL = filePath;
        _previewItem = item;
    }
    return self;
}

- (id)initWithRemoteFile:(NSURL *)remoteUrl {
    return [self initWithRemoteFile:remoteUrl title:remoteUrl.lastPathComponent];
}

- (id)initWithRemoteFile:(NSURL *)remoteUrl title:(NSString *)title {
    self = [self init];
    if (self) {
        AMPPreviewObject *item = [AMPPreviewObject new];
        item.previewItemTitle = title;
        item.remoteUrl = remoteUrl;
        _previewItem = item;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([self.previewItem respondsToSelector:@selector(remoteUrl)]
        && [(id <AMPPreviewItem>)self.previewItem remoteUrl]) {

        id <AMPPreviewItem> item = (id <AMPPreviewItem>)self.previewItem;
        NSURL *suggestedLocalURL = [self destinationPathForURL:[item remoteUrl]];
        if ([[NSFileManager defaultManager] fileExistsAtPath:[suggestedLocalURL path]]) {
            item.previewItemURL = suggestedLocalURL;
            self.dataSource = self;
            [self reloadData];
        } else {
            [self downloadFile];
        }

    } else {
        self.dataSource = self;
        [self reloadData];
    }
}

- (NSURL *)destinationPathForURL:(NSURL *)url {
    NSURL *documentsDirectoryPath = [NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]];
    NSString *name = [url lastPathComponent];
    NSURL *path = [documentsDirectoryPath URLByAppendingPathComponent:name];
    return path;
}

#pragma mark -

- (void)downloadFile {
    if (self.startDownloadBlock) {
        self.startDownloadBlock();
    }
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [(id <AMPPreviewItem>)self.previewItem remoteUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        return [self destinationPathForURL:URL];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (!error) {
//            NSLog(@"File downloaded to: %@", filePath);
            
            if ([self.previewItem isKindOfClass:[AMPPreviewObject class]]) {
                [(AMPPreviewObject *)self.previewItem setPreviewItemTitle:[response suggestedFilename]];
            }
            [(id <AMPPreviewItem>)self.previewItem setPreviewItemURL:filePath];
            
            self.dataSource = self;
            [self reloadData];
        }
        
        if (self.finishDownloadBlock) {
            self.finishDownloadBlock(error);
        }
    }];
    [downloadTask resume];
}

#pragma mark - QLPreviewControllerDataSource

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller {
    return 1;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    return self.previewItem;
}

@end
