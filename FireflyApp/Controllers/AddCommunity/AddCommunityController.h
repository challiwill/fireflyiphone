#import <UIKit/UIKit.h>
#import "FireflyClient.h"
#import "CommunityListController.h"

@interface AddCommunityController : UIViewController

@property (nonatomic, readonly) FireflyClient *backendClient;

- (instancetype)initWithBackendClient:(FireflyClient *)backendClient User:(User *)user;

@end
