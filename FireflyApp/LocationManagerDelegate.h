#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Mapbox/Mapbox.h"

@interface LocationManagerDelegate: NSObject <CLLocationManagerDelegate>

@property (nonatomic, readonly) MGLMapView *mapView;

- (instancetype)initWithMapView:(MGLMapView *)mapView;
@end
