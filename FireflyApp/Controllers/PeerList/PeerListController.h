#import <UIKit/UIKit.h>
#import "FireflyClient.h"
#import "PeerListDataSourceDelegate.h"

@interface PeerListController : UIViewController


@property (nonatomic, readonly) FireflyClient *backendClient;
@property (nonatomic, readonly) CLLocationManager *locationManager;
@property (nonatomic, readonly) UITableView *tableView;
@property (nonatomic, readonly) PeerListDataSourceDelegate *tableViewDataSourceDelegate;

- (instancetype)initWithBackendClient:(FireflyClient *)backendClient LocationManager:(CLLocationManager *)locationManager User:(User *)user;

@end