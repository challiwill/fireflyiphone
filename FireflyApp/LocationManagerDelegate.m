#import "LocationManagerDelegate.h"

@interface LocationManagerDelegate ()

@property (nonatomic) MGLMapView *mapView;

@end

@implementation LocationManagerDelegate

- (instancetype)initWithMapView:(MGLMapView *)mapView
{
    self = [super init];
    if (self) {
        self.mapView = mapView;
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
}

@end
