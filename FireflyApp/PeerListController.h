#import <UIKit/UIKit.h>
#import "Mapbox/Mapbox.h"
#import "FireflyClient.h"

@interface PeerListController : UIViewController


@property (nonatomic, readonly) FireflyClient *backendClient;
@property (nonatomic, readonly) CLLocationManager *locationManager;

- (instancetype)initWithBackendClient:(FireflyClient *)backendClient LocationManager:(CLLocationManager *)locationManager;

@end