#import "MapScreenController.h"

@interface MapScreenController ()

@property (nonatomic) FireflyClient *backendClient;
@property (nonatomic) MGLMapView *mapView;
@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) LocationManagerDelegate *locationDelegate;

@end

CLLocation *BERKELEY;

@implementation MapScreenController

- (instancetype)initWithBackendClient:(FireflyClient *)backendClient
                      LocationManager:(CLLocationManager *) locationManager
                              MapView:(MGLMapView *)mapView
{
    self = [super init];
    if (self) {
        self.backendClient = backendClient;
        self.mapView = mapView;
        self.locationManager = locationManager;
        BERKELEY = [[CLLocation alloc] initWithLatitude:37.871912 longitude:-122.258537];
    }
    return self;
}

- (void)loadView
{
    CGRect frame = [[UIScreen mainScreen] bounds];

    self.view = [[UIView alloc] initWithFrame:frame];
    [self.view addSubview:self.mapView];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.mapView setCenterCoordinate:BERKELEY.coordinate
                            zoomLevel:15
                             animated:NO];
    
    self.locationDelegate =[[LocationManagerDelegate alloc] initWithMapView:self.mapView
                            BackendClient:self.backendClient];
    self.locationManager.delegate = self.locationDelegate;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.mapView.showsUserLocation = YES;
    
    CLAuthorizationStatus authStatus = CLLocationManager.authorizationStatus;
    if (authStatus == kCLAuthorizationStatusAuthorizedAlways) {
        [self.locationManager startUpdatingLocation];
    } else {
        [self.locationManager requestAlwaysAuthorization];
    }
}

@end
