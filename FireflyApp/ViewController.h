#import <UIKit/UIKit.h>

@class FireflyClient;

@interface ViewController : UIViewController

- (instancetype)initWithBackendClient:(FireflyClient *)backendClient;

@end

