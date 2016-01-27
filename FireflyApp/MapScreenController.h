#import <UIKit/UIKit.h>
#import "FireflyClient.h"
#import "Mapbox/Mapbox.h"
#import "LocationManagerDelegate.h"
#import <CoreLocation/CoreLocation.h>

@interface MapScreenController: UIViewController

@property (nonatomic, readonly) FireflyClient *backendClient;
@property (nonatomic, readonly) MGLMapView *mapView;
@property (nonatomic, readonly) CLLocationManager *locationManager;
@property (nonatomic, readonly) LocationManagerDelegate *locationDelegate;

- (instancetype)initWithBackendClient:(FireflyClient *)backendClient LocationManager:(CLLocationManager *)locationManager andMapView:(MGLMapView *)mapView;

@end
