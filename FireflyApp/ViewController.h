#import <UIKit/UIKit.h>

@class FireflyClient;

@interface ViewController : UIViewController

@property (nonatomic, readonly) FireflyClient *backendClient;

- (instancetype)initWithBackendClient:(FireflyClient *)backendClient;

@end

