//
//  AMPPreviewController.h
//  uikitadditions
//
//  Created by Alejandro Martinez on 09/09/12.
//  Copyright (c) 2012 Alejandro Martinez. All rights reserved.
//

#import <QuickLook/QuickLook.h>

/* TODO
- We are using the [NSURLResponse suggestedName] to creathe the local path of the
 donwnloaded file. Because of that we can't create the string for the local path 
 withouth making a netwrok connection, so we can't check if the file for that url 
 exist -> it wil always donload the file.
 To avoid that is posbile to init the controller with a <AMPPreviewItem> object
 that is persisted in the finishDownloadBlock. That works because we check for the
 previewItemURL before start downloading the file and set that URL when downloading is
 complete.
 We could implement a persistent cache to save the "url -> local path".
*/
/**
 *  AMPPreviewController it's a subclass of QLPreviewController that
 *  allows you to preview remote documents.
 *
 *  This class downloads the document and then reloads the preview.
 *
 *  This class is deisgned to work with only one document at a time.
 *  So the developer doesn't need to deal with dataSource methods,
 *  just instantiate and present ;)
 *
 *  Also you can use directly NSURL's! Without creating a QLPreviewItem
 *  conforming object.
 */

typedef void (^AMPPreviewControllerStartDownload)();
typedef void (^AMPPreviewControllerFinishDownload)(NSError *error);

@protocol AMPPreviewItem <QLPreviewItem>
@required
- (NSURL *)remoteUrl;
@property (strong) NSURL * previewItemURL;
@end

@interface AMPPreviewController : QLPreviewController

/**
 *  Use a confirming <QLPreviewItem> object.
 *  It's the same as using QLPreviewController directly but
 *  Not need to implement QLPreviewControllerDataSource!
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
 *  No need to create a confirming <QLPreviewItem> object.
 *
 *  @param filePath The path for the local document
 */
- (id)initWithFilePath:(NSURL *)filePath;

/**
 *  Use a remote url.
 *  This will donwload and preview the remote document.
 *  
 *  Note: This methos always will download the file. It
 *  can't know if the file is alredy downloaded. Use
 *  -initWithPreviewItem: with a <AMPPreviewItem> object
 *  instead.
 *
 *  @param remoteUrl The url for the remote document
 */
- (id)initWithRemoteFile:(NSURL *)remoteUrl;

@property (nonatomic, copy) AMPPreviewControllerStartDownload startDownloadBlock;
@property (nonatomic, copy) AMPPreviewControllerFinishDownload finishDownloadBlock;

@end
