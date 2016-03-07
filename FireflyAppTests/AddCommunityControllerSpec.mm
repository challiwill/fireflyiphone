#import <Cedar/Cedar.h>
#import "AddCommunityController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(AddCommunityControllerSpec)

describe(@"AddCommunityController", ^{
    __block AddCommunityController *subject;

    beforeEach(^{
        subject = [[AddCommunityController alloc] init];
    });
});

SPEC_END
