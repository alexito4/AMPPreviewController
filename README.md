# AMPPreviewController

[![Version](http://cocoapod-badges.herokuapp.com/v/AMPPreviewController/badge.png)](http://cocoadocs.org/docsets/AMPPreviewController)
[![Platform](http://cocoapod-badges.herokuapp.com/p/AMPPreviewController/badge.png)](http://cocoadocs.org/docsets/AMPPreviewController)


AMPPreviewController is a subclass of QLPreviewController that allows you to preview remote documents.

This class is designed to work with only one document at a time.

Also you can use a NSURL directly! Without the need of creating a QLPreviewItem conforming object.
So the developer doesn't need to deal with dataSource methods, just instantiate and present ;)

## Usage

### With a remote URL

Just open a remote url:

    NSURL *remoteURL = ...
    AMPPreviewController *pc = [[AMPPreviewController alloc]
                                initWithRemoteFile:remoteURL];
    [self presentViewController:pc animated:YES completion:nil];

You can also execute a block when the download starts or ends:

    [pc setStartDownloadBlock:^(){
        ...
    }];
    [pc setFinishDownloadBlock:^(NSError *error){
        ...
    }];

### With a local path

You can also load a local file. This is the same as using the QLPreviewController but more simple if you just want to present a **single file**.

    NSURL *localPath = ...
    AMPPreviewController *pc = [[AMPPreviewController alloc] initWithFilePath:localPath];
    [self presentViewController:pc animated:YES completion:nil];


### With a preview item

    MyItem *item = ...
    AMPPreviewController *pc = [[AMPPreviewController alloc] initWithPreviewItem:item];
    [self presentViewController:pc animated:YES completion:nil];

The *item* must conform to the `QLPreviewItem` protocol.

Additionally it can also conform to `AMPPreviewItem` wich adds the required `remoteUrl` method.
It will be the same as using the `initWithRemoteFile:` method but with your own object.

## Installation

AMPPreviewController is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "AMPPreviewController"

## Author

Alejandro Martinez, alexito4@gmail.com

## License

AMPPreviewController is available under the MIT license. See the LICENSE file for more info.
