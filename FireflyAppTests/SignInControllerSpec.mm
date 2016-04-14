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
            backendClient stub_method("signInWithUsername:Password:SuccessBlock:FailureBlock:")
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
            
            [subject signInWithUsername:@"username"
                               Password:@"password"
                           SuccessBlock:^void(User *user){successBlockCalled = true;}
                           FailureBlock:^void (){failureBlockCalled = true;}];
            
        });
        
        it(@"should sign in with correct username and password", ^{
            username should equal(@"username");
            password should equal(@"password");
        });
        
        context(@"sign in succeeds", ^{
            beforeEach(^{
                User *user = nice_fake_for([User class]);
                simulateSuccess(user);
            });
            
            it(@"should call success block", ^{
                successBlockCalled should be_truthy;
            });
            
            it(@"should segue to peer list controller", ^{
                //TODO: Not sure about testing segues
            });
        });
        
        context(@"sign in fails", ^{
            beforeEach(^{
                simulateFailure();
            });
            
            it(@"should call failure block", ^{
                failureBlockCalled should be_truthy;
            });
        });
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
