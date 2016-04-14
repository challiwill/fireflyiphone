#import <Cedar/Cedar.h>
#import "LocationManagerDelegate.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(LocationManagerDelegateSpec)

describe(@"LocationManagerDelegate", ^{
    __block LocationManagerDelegate *subject;

    beforeEach(^{
        subject = [[LocationManagerDelegate alloc] init];
    });
    //TODO
    describe(@"initWithMapView:BackendClient:", ^{
        
    });
    
    describe(@"locationManager:didChangeAuthorizationStatus:", ^{
        
    });
    
    describe(@"locationManager:didUpdateLocations:", ^{
        
    });
});

SPEC_END
