#import <UIKit/UIKit.h>
#import "FireflyClient.h"
#import "StandardSegue.h"
#import "SignInController.h"
#import "User.h"

@interface SignUpController : UIViewController

@property (nonatomic, readonly) FireflyClient *backendClient;

- (instancetype)initWithBackendClient:(FireflyClient *)backendClient;
- (void)cancel;
- (void)signUpWithUsername:(NSString *)username Password:(NSString *)password SuccessBlock:(void (^)(User *))successBlock FailureBlock:(void (^)())failureBlock;
- (void)segueToCommunityListController:(User *)user;

@end
