#import "LocationManagerDelegate.h"

@interface LocationManagerDelegate ()

@property (nonatomic) MGLMapView *mapView;
@property (nonatomic) FireflyClient *backendClient;


@end

@implementation LocationManagerDelegate

- (instancetype)initWithMapView:(MGLMapView *)mapView
                  BackendClient:(FireflyClient *)backendClient
{
    self = [super init];
    if (self) {
        self.mapView = mapView;
        self.backendClient = backendClient;
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
                          SuccessBlock:nil
                          FailureBlock:^void () {[self.backendClient reportLocationUpdateError];}];
}



@end
