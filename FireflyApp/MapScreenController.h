#import <UIKit/UIKit.h>
#import "FireflyClient.h"
#import "Mapbox/Mapbox.h"

@interface MapScreenController: UIViewController

@property (nonatomic, readonly) FireflyClient *backendClient;
@property (nonatomic, readonly) MGLMapView *mapView;

- (instancetype)initWithBackendClient:(FireflyClient *)backendClient andMapView:(MGLMapView *) mapView;

@end
