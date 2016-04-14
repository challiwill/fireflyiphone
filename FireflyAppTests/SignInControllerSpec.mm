#import <Cedar/Cedar.h>
#import "SignInController.h"
#import "FireflyClient.h"
#import "AppDelegate.h"

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
    
    describe(@"-signIn", ^{
        // TODO delegates to backendClient which is tested independently
        // still test success/failure block actions
    });
    
    // TODO how to test that segue happens?
    // probably fake the StandardSegue object and make sure it is called
    //   with the right arguments
    // cannot test with view controllers because it's not actually in the
    //   context
    describe(@"-segueToPeerList", ^{
        __block User *user;
        beforeEach(^{
            user = nice_fake_for([User class]);
        });
        
        subjectAction(^{
            [subject segueToPeerList:user];
        });
        
        it(@"should segue to the map view controller", ^{
        });
    });
    
    describe(@"segueToSignUpScreen", ^{
        //TODO should this even be tested?
    });
});

SPEC_END
