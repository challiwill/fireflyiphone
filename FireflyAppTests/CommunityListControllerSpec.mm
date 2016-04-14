#import <Cedar/Cedar.h>
#import "CommunityListController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(CommunityListControllerSpec)

describe(@"CommunityListController", ^{
    __block CommunityListController *subject;

    beforeEach(^{
        subject = [[CommunityListController alloc] init];
    });
    //TODO
});

SPEC_END
