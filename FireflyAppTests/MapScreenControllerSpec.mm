#import <Cedar/Cedar.h>
#import "MapScreenController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(MapScreenControllerSpec)

describe(@"MapScreenController", ^{
    __block MapScreenController *subject;
    __block FireflyClient *backendClient;

    beforeEach(^{
        backendClient = nice_fake_for([FireflyClient class]);
        subject = [[MapScreenController alloc] initWithBackendClient:backendClient];
    });
});

SPEC_END
