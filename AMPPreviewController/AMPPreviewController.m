//
//  AMPPreviewController.m
//  uikitadditions
//
//  Created by Alejandro Martinez on 09/09/12.
//  Copyright (c) 2012 Alejandro Martinez. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#import "AMPPreviewController.h"

#pragma mark - AMPPreviewItem

@interface AMPPreviewObject : NSObject <AMPPreviewItem>
@property (nonatomic, strong) NSURL *remoteUrl;
@property (strong, readwrite) NSURL *previewItemURL;
@property (strong, readwrite) NSString *previewItemTitle;
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
        item.previewItemTitle = @"Title";
        item.previewItemURL = filePath;
        _previewItem = item;
    }
    return self;
}

- (id)initWithRemoteFile:(NSURL *)remoteUrl {
    self = [self init];
    if (self) {
        AMPPreviewObject *item = [AMPPreviewObject new];
        item.previewItemTitle = @"Title";
        item.remoteUrl = remoteUrl;
        _previewItem = item;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([self.previewItem respondsToSelector:@selector(remoteUrl)]
        && [(id <AMPPreviewItem>)self.previewItem remoteUrl]) {
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:[[self.previewItem previewItemURL] path]]) {
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
        NSURL *documentsDirectoryPath = [NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]];
        NSURL *path = [documentsDirectoryPath URLByAppendingPathComponent:[response suggestedFilename]];
        return path;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (!error) {
            NSLog(@"File downloaded to: %@", filePath);
            
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
