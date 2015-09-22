#import <UIKit/UIKit.h>

@class FireflyClient;

@interface SignInController : UIViewController

@property (nonatomic, readonly) FireflyClient *backendClient;
@property (nonatomic, readonly) UITextField *emailField;
@property (nonatomic, readonly) UITextField *passwordField;
@property (nonatomic, readonly) UIButton *signInButton;

- (instancetype)initWithBackendClient:(FireflyClient *)backendClient;

@end

