#import <Cedar/Cedar.h>
#import "SignUpController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(SignUpControllerSpec)

describe(@"SignUpController", ^{
    __block SignUpController *subject;

    beforeEach(^{
        subject = [[SignUpController alloc] init];
    });
});

SPEC_END
