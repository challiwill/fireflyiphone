#import <UIKit/UIKit.h>
#import "FireflyClient.h"
#import "SignUpController.h"
#import "StandardSegue.h"
#import "PeerListController.h"
#import "User.h"

@class FireflyClient;

@interface SignInController : UIViewController

@property (nonatomic, readonly) FireflyClient *backendClient;
@property (nonatomic, readonly) UITextField *emailField;
@property (nonatomic, readonly) UITextField *passwordField;
@property (nonatomic, readonly) UIButton *signInButton;

- (instancetype)initWithBackendClient:(FireflyClient *)backendClient;
- (void)signIn;
- (void)segueToPeerList:(User *)user;

@end

