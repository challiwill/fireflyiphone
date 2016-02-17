#import <UIKit/UIKit.h>
#import "FireflyClient.h"
#import "StandardSegue.h"
#import "SignInController.h"

@interface SignUpController : UIViewController

@property (nonatomic, readonly) FireflyClient *backendClient;

- (instancetype)initWithBackendClient:(FireflyClient *)backendClient;

@end
