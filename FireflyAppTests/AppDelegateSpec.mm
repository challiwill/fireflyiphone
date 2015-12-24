#import "Cedar.h"
#import "AppDelegate.h"
#import "SignInController.h"
#import "FireflyClient.h"

using namespace Cedar::Matchers;

SPEC_BEGIN(AppDelegateSpecSpec)

describe(@"AppDelegate", ^{
    __block AppDelegate *subject;
    
    beforeEach(^{
        subject = [[AppDelegate alloc] init];
    });
    
    describe(@"as a <UIApplicationDelegate>", ^{
        describe(@"-application:didFinishLaunchingWithOptions:", ^{
            __block BOOL returnValue;
            
            subjectAction(^{
                returnValue = [subject application:nil didFinishLaunchingWithOptions:nil];
            });
            
            it(@"should return YES", ^{
                returnValue should be_truthy;
            });
            
            it(@"should have a window", ^{
                subject.window should be_instance_of([UIWindow class]);
            });
            
            it(@"should set the window's frame correctly", ^{
                BOOL frameIsAsLargeAsTheScreen = CGRectEqualToRect(subject.window.frame, [[UIScreen mainScreen] bounds]);
                frameIsAsLargeAsTheScreen should be_truthy;
            });
            
            it(@"should set the window's root view controller correctly", ^{
                subject.window.rootViewController should be_instance_of([SignInController class]);
            });
            
            it(@"should inject the root view controller's properties", ^{
                SignInController *signInController = (SignInController *)subject.window.rootViewController;
                signInController.backendClient should_not be_nil;
            });
            
            it(@"should make the window the key window", ^{
                [subject.window isKeyWindow] should be_truthy;
            });
            
            it(@"should make the window visible", ^{
                [subject.window isHidden] should be_falsy;
            });
        });
    });
});

SPEC_END
