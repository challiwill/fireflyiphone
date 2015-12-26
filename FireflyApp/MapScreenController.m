#import "MapScreenController.h"
#import "FireflyClient.h"
#import "Mapbox/Mapbox.h"

@interface MapScreenController ()

@property (nonatomic) FireflyClient *backendClient;
@property (nonatomic) MGLMapView *mapView;

@end

@implementation MapScreenController


- (instancetype)initWithBackendClient:(FireflyClient *)backendClient andMapView:(MGLMapView *)mapView
{
    self = [super init];
    if (self) {
        self.backendClient = backendClient;
        self.mapView = mapView;
    }
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 800)];
    [self.view addSubview:self.mapView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    // set the map's center coordinate
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(38.894368, -77.036487)
                            zoomLevel:15
                             animated:NO];
}

@end
