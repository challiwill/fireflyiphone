#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Mapbox/Mapbox.h"
#import "FireflyClient.h"

@class FireflyClient;

@interface LocationManagerDelegate: NSObject <CLLocationManagerDelegate>

@property (nonatomic, readonly) MGLMapView *mapView;
@property (nonatomic, readonly) FireflyClient *backendClient;

- (instancetype)initWithMapView:(MGLMapView *)mapView
                  BackendClient:(FireflyClient *)backendClient;
@end
