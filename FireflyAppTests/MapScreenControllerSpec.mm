#import <Cedar/Cedar.h>
#import "MapScreenController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(MapScreenControllerSpec)

describe(@"MapScreenController", ^{
    __block MapScreenController *subject;
    __block FireflyClient *backendClient;
    __block MGLMapView *mapView;

    beforeEach(^{
        backendClient = nice_fake_for([FireflyClient class]);
        mapView = nice_fake_for([MGLMapView class]);
        subject = [[MapScreenController alloc] initWithBackendClient:backendClient andMapView:mapView];
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

        it(@"should center the map on the user", ^{
           // TODO
        });
    });
});

SPEC_END
