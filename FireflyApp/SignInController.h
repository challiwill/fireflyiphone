#import <UIKit/UIKit.h>
#import "FireflyClient.h"
#import "SignUpController.h"
#import "StandardSegue.h"
#import "Mapbox/Mapbox.h"
#import "PeerListController.h"

@class FireflyClient;

@interface SignInController : UIViewController

@property (nonatomic, readonly) FireflyClient *backendClient;
@property (nonatomic, readonly) UITextField *emailField;
@property (nonatomic, readonly) UITextField *passwordField;
@property (nonatomic, readonly) UIButton *signInButton;

- (instancetype)initWithBackendClient:(FireflyClient *)backendClient;
- (void)signIn;
- (void)segueToPeerList;

@end

