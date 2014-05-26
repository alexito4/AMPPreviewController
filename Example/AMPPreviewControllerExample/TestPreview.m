#import "TestPreview.h"

@implementation TestPreview

- (NSURL *)previewItemURL {
    NSURL *documentsDirectoryPath = [NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]];
    NSURL *url = [documentsDirectoryPath URLByAppendingPathComponent:@"growth_in_time_debt_aer.pdf"];
    return url;
}

- (NSString *)previewItemTitle {
    return @"SIMPLE QLPreviewItem";
}

@end
