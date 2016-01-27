#import <Cedar/Cedar.h>
#import "MapScreenController.h"
#import <CoreLocation/CoreLocation.h>

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(MapScreenControllerSpec)

describe(@"MapScreenController", ^{
    __block MapScreenController *subject;
    __block FireflyClient *backendClient;
    __block CLLocationManager *locationManager;
    __block MGLMapView *mapView;
    
    beforeEach(^{
        backendClient = nice_fake_for([FireflyClient class]);
        locationManager = nice_fake_for([CLLocationManager class]);
        mapView = nice_fake_for([MGLMapView class]);
        
        subject = [[MapScreenController alloc] initWithBackendClient:backendClient LocationManager:locationManager andMapView:mapView];
    });
    
    describe(@"-loadView", ^{
        subjectAction(^{
            [subject loadView];
        });
        
        describe(@"presents a map", ^{
            it(@"should show a map", ^{
                subject.mapView should_not be_nil;
            });
        });
    });
    
    describe(@"-viewDidLoad", ^{
        subjectAction(^{
            [subject loadView];
            [subject viewDidLoad];
        });
        
        describe(@"if location services are enabled",^{
            it(@"should center the map on the user", ^{
//                CLLocationCoordinate2D userLocation = CLLocationCoordinate2DMake(0,0);
//                subject.mapView.centerCoordinate should be_close_to(userLocation);
            });
        });
        
        describe(@"if location services are disabled",^{
            it(@"should center the map on Berkeley campus", ^{
                // TODO
            });
            
            it(@"should display an error message", ^{
                // TODO
            });
        });
    });
});

SPEC_END
