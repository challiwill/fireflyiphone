#import <UIKit/UIKit.h>
#import "FireflyClient.h"
#import "CommunityListDataSourceDelegate.h"
#import "StandardSegue.h"
#import "AddCommunityController.h"

@interface CommunityListController : UIViewController

@property (nonatomic, readonly) FireflyClient *backendClient;
@property (nonatomic, readonly) User *user;

- (instancetype)initWithBackendClient:(FireflyClient *)backendClient User:(User *)user;

@end
