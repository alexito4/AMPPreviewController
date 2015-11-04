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

#import <QuickLook/QuickLook.h>

/**
 *  AMPPreviewController is a subclass of QLPreviewController that
 *  allows you to preview remote documents.
 *
 *  This class downloads the document and then reloads the preview.
 *
 *  This class is designed to work with only one document at a time.
 *  Also you can use a NSURL directly! Without the need of creating a QLPreviewItem conforming object.
 *  So the developer doesn't need to deal with dataSource methods, just instantiate and present ;)
 *
 */

typedef void (^AMPPreviewControllerStartDownload)();
typedef void (^AMPPreviewControllerFinishDownload)(NSError *error);

@protocol AMPPreviewItem <QLPreviewItem>
@required
- (NSURL *)remoteUrl;
@property (readwrite, nonatomic) NSURL * previewItemURL;
@end

@interface AMPPreviewController : QLPreviewController

/**
 *  Use a confirming <QLPreviewItem> object.
 *  It's the same as using QLPreviewController directly but
 *  thre is no need to implement QLPreviewControllerDataSource!
 *
 *  But you can use a <AMPPreviewItem> conforming object also.
 *  If the object has the remoteUrl != nil it will donwload the file.
 *
 *  If the object has the previewItemURL != nil it will load the file
 *  instead of downloading it.
 */
- (id)initWithPreviewItem:(id <QLPreviewItem>)item;

/**
 *  Use just a file path.
 *  No need to create a confirming <QLPreviewItem> object
 *  nor implementing the data source.
 *
 *  @param filePath The path for the local document
 */
- (id)initWithFilePath:(NSURL *)filePath;

/**
 *  Use a remote url.
 *  This will download and preview the remote document.
 *
 *  @param remoteUrl The url for the remote document
 */
- (id)initWithRemoteFile:(NSURL *)remoteUrl;

/**
 *  Use a remote url.
 *  This will download and preview the remote document.
 *
 *  @param remoteUrl The url for the remote document
 *  @param title The default title for the remote document
 */
- (id)initWithRemoteFile:(NSURL *)remoteUrl title:(NSString *)title;

/**
 *  Executed when the download of the file starts.
 */
@property (nonatomic, copy) AMPPreviewControllerStartDownload startDownloadBlock;

/**
 *  Executed when the download of the file has ended.
 */
@property (nonatomic, copy) AMPPreviewControllerFinishDownload finishDownloadBlock;

@end
