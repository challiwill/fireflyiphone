#import <Cedar/Cedar.h>
#import "CommunityListDataSourceDelegate.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(CommunityListDataSourceDelegateSpec)

describe(@"CommunityListDataSourceDelegate", ^{
    __block CommunityListDataSourceDelegate *subject;
    
    beforeEach(^{
        subject = [[CommunityListDataSourceDelegate alloc] init];
    });

});

SPEC_END
