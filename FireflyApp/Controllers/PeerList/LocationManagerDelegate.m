#import "LocationManagerDelegate.h"

@interface LocationManagerDelegate ()

// TODO get rid of mapView
@property (nonatomic) MGLMapView *mapView;
@property (nonatomic) FireflyClient *backendClient;
@property(nonatomic) User *user;


@end

@implementation LocationManagerDelegate

- (instancetype)initWithMapView:(MGLMapView *)mapView
                  BackendClient:(FireflyClient *)backendClient
                           User:(User *)user
{
    self = [super init];
    if (self) {
        self.mapView = mapView;
        self.backendClient = backendClient;
        self.user = user;
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusRestricted
        || status == kCLAuthorizationStatusDenied) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Services Denied"
                                                        message:@"You must enable location services in order to use this app."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    } else if (status == kCLAuthorizationStatusNotDetermined) {
    } else {
    }
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [locations lastObject];
    [self.mapView setCenterCoordinate:newLocation.coordinate
                            zoomLevel:15
                             animated:NO];
    [self.backendClient updateLocation:newLocation
                               ForUser:self.user
                          SuccessBlock:nil
                          FailureBlock:nil];
}



@end
