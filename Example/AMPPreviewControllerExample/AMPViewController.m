
#import "AMPViewController.h"
#import <AMPPreviewController/AMPPreviewController.h>

#import "TestPreview.h"

@interface AMPViewController ()

@end

@implementation AMPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

- (IBAction)openFromRemoteURL:(id)sender {
    // DOWNLOAD FROM A REMOTE URL
    AMPPreviewController *pc = [[AMPPreviewController alloc]
                                initWithRemoteFile:[NSURL URLWithString:@"http://scholar.harvard.edu/files/rogoff/files/growth_in_time_debt_aer.pdf"]];
    [pc setStartDownloadBlock:^(){
        NSLog(@"Start download");
    }];
    [pc setFinishDownloadBlock:^(NSError *error){
        NSLog(@"Download finished %@", error);
    }];
    [self presentViewController:pc animated:YES completion:nil];
}

- (IBAction)openFromLocalPath:(id)sender {
    // First use the remote method to download the file ;)
    
    // OPEN FORM LOCAL PATH
    NSURL *documentsDirectoryPath = [NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]];
    NSURL *path = [documentsDirectoryPath URLByAppendingPathComponent:@"growth_in_time_debt_aer.pdf"];
    AMPPreviewController *pc = [[AMPPreviewController alloc] initWithFilePath:path];
    
    [self presentViewController:pc animated:YES completion:nil];
}

- (IBAction)openWithQLPreviewItem:(id)sender {
    // Use it as always, with an <QLPreviewItem> conforming object with a file path.
    TestPreview *po = [TestPreview new];
    AMPPreviewController *pc = [[AMPPreviewController alloc] initWithPreviewItem:po];
    
    [self presentViewController:pc animated:YES completion:nil];
}

@end
