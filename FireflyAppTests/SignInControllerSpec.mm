#import <Cedar/Cedar.h>
#import "SignInController.h"
#import "FireflyClient.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(SignInControllerSpec)

describe(@"SignInController", ^{
    __block SignInController *subject;
    __block FireflyClient *backendClient;
    
    beforeEach(^{
        backendClient = nice_fake_for([FireflyClient class]);
        subject = [[SignInController alloc] initWithBackendClient:backendClient];
    });

    describe(@"-loadView", ^{
        subjectAction(^{
            [subject loadView];
        });
        
        describe(@"presents a sign in form", ^{
            it(@"should provide a field for email ", ^{
                subject.emailField should_not be_nil;
            });
            
            it(@"should provide a field for password", ^{
                subject.passwordField should_not be_nil;
            });
        });
    });

    describe(@"-viewDidLoad", ^{
        subjectAction(^{
            [subject loadView];
            [subject viewDidLoad];
        });
        
        it(@"should hide the password field contents", ^{
            subject.passwordField.secureTextEntry should be_truthy;
        });
    });
});

SPEC_END
