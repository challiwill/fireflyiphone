#import "PeerListController.h"

@interface PeerListController ()

@property (nonatomic) FireflyClient *backendClient;
@property (nonatomic) CLLocationManager *locationManager;

@end

@implementation PeerListController

- (instancetype)initWithBackendClient:(FireflyClient *)backendClient LocationManager:(CLLocationManager *)locationManager
{
    self = [super init];
    if (self) {
        self.backendClient = backendClient;
        self.locationManager = locationManager;
    }
    return self;}

- (void)viewDidLoad
{
    [super viewDidLoad];
}


@end