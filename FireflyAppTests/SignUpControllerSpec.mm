#import <Cedar/Cedar.h>
#import "SignUpController.h"
#import "FireflyClient.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(SignUpControllerSpec)

describe(@"SignUpController", ^{
    __block SignUpController *subject;
    __block FireflyClient *backendClient;
    
    beforeEach(^{
        backendClient = nice_fake_for([FireflyClient class]);
        subject = [[SignUpController alloc] initWithBackendClient:backendClient];
    });
    
    describe(@"-cancel", ^{
        subjectAction(^{
            [subject cancel];
        });
        
        it(@"should segue to SignIn", ^{
            // Not sure about testing segues
            // Could split into separate functions like signup
        });
    });
    
    describe(@"-signUp", ^{
        __block NSString *username;
        __block NSString *password;
        __block void (^simulateSuccess)(User *);
        __block void (^simulateFailure)();
        __block bool successBlockCalled;
        __block bool failureBlockCalled;
        
        beforeEach(^{
            username = nil;
            password = nil;
            simulateSuccess = nil;
            simulateFailure = nil;
            successBlockCalled = false;
            failureBlockCalled = false;
            backendClient stub_method("signUpWithUsername:Password:SuccessBlock:FailureBlock:")
            .and_do_block(^(
                            NSString *incomingUsername,
                            NSString *incomingPassword,
                            void (^incomingSuccessHandler)(User *),
                            void (^incomingFailureHandler)()
                            )
                          {
                              username = incomingUsername;
                              password = incomingPassword;
                              simulateSuccess = incomingSuccessHandler;
                              simulateFailure = incomingFailureHandler;
                          });
            
            [subject signUpWithUsername:@"username"
                               Password:@"password"
                           SuccessBlock:^void(User *user){successBlockCalled = true;}
                           FailureBlock:^void (){failureBlockCalled = true;}];
            
        });
        
        it(@"should sign up with correct username and password", ^{
            username should equal(@"username");
            password should equal(@"password");
        });
        
        context(@"sign up succeeds", ^{
            beforeEach(^{
                User *user = nice_fake_for([User class]);
                simulateSuccess(user);
            });
            
            it(@"should call success block", ^{
                successBlockCalled should be_truthy;
            });
            
            it(@"should segue to community list controller", ^{
                // Not sure about testing segues
            });
        });
        
        context(@"sign up fails", ^{
            beforeEach(^{
                simulateFailure();
            });
            
            it(@"should call failure block", ^{
                failureBlockCalled should be_truthy;
            });
        });
    });
});

SPEC_END
