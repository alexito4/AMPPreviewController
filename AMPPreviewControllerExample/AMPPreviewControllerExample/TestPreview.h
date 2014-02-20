#import <Foundation/Foundation.h>
#import <QuickLook/QLPreviewItem.h>

@interface TestPreview : NSObject <QLPreviewItem>

- (NSString *)previewItemTitle;
- (NSURL *)previewItemURL;

@end
