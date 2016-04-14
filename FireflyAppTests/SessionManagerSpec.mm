#import <Cedar/Cedar.h>
#import "SessionManager.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(SessionManagerSpec)

describe(@"SessionManager", ^{
    __block SessionManager *subject;
    __block NSURL *baseURL;

    beforeEach(^{
        baseURL = [[NSURL alloc] initWithString:@"http://some.url"];
        subject = [[SessionManager alloc] initWithBaseURL:baseURL];
    });
    //TODO
    describe(@"-POST:parameters:success:failure:", ^{
        subjectAction(^{
            [subject POST:@"/some/path" parameters:nil success:nil failure:nil];
        });
 
        it(@"makes a post request to the specified path and baseURL", ^{

        });
 
        it(@"makes a post request with the specified parameters", ^{
 
        });
 
        context(@"when the post succeeds", ^{
            it(@"calls the success block", ^{
 
            });
        });
 
        context(@"when the post fails", ^{
            it(@"calls the failure block", ^{
 
            });
        });
    });
 
});

SPEC_END
