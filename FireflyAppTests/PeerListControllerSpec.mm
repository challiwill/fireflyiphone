#import <Cedar/Cedar.h>
#import "PeerListController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(PeerListControllerSpec)

describe(@"PeerListController", ^{
    __block PeerListController *subject;

    beforeEach(^{
        subject = [[PeerListController alloc] init];
    });
});

SPEC_END
