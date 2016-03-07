#import "Cedar.h"
#import "FireflyClient.h"
#import "AFNetworking/AFHTTPSessionManager.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(FireflyClientSpec)

describe(@"FireflyClient", ^{
    __block FireflyClient *subject;
    __block AFHTTPSessionManager *manager;
    __block bool successBlockCalled;
    __block bool failureBlockCalled;
    
    
    beforeEach(^{
        manager = nice_fake_for([AFHTTPSessionManager class]);
        subject = [[FireflyClient alloc] initWithManager:manager];
    });
    
    // USER
    describe(@"-signUpWithUsername:Password:SuccessBlock:FailureBlock:", ^{
        
    });
    
    describe(@"-signInWithUsername:Password:SuccessBlock:FailureBlock:", ^{
        __block NSString *urlString;
        __block NSDictionary *parameters;
        __block void (^progress)(NSProgress *);
        __block void (^simulateSuccess)(NSURLSessionTask *, id);
        __block void (^simulateFailure)(NSURLSessionTask *, NSError *);
        
        beforeEach(^{
            urlString = nil;
            parameters = nil;
            progress = nil;
            simulateSuccess = nil;
            simulateFailure = nil;
            successBlockCalled = false;
            failureBlockCalled = false;
            manager stub_method("POST:parameters:progress:success:failure:")
            .and_do_block(^id (
                               NSString *incomingURLString,
                               NSDictionary *incomingParameters,
                               void (^incomingProgress)(NSProgress *),
                               void (^incomingSuccessHandler)(NSURLSessionTask *, id),
                               void (^incomingFailureHandler)(NSURLSessionTask *, NSError *)
                               )
                          {
                              urlString = incomingURLString;
                              parameters = incomingParameters;
                              progress = incomingProgress;
                              simulateSuccess = incomingSuccessHandler;
                              simulateFailure = incomingFailureHandler;
                              return 0;
                          });
            
            [subject signInWithUsername:@"testemail@berkeley.edu"
                               Password:@"password"
                           SuccessBlock:^void(){successBlockCalled = true;}
                           FailureBlock:^void(){failureBlockCalled = true;}];
        });
        
        it(@"should send a request to the correct URL", ^{
            urlString should equal(@"/auth/sign_in");
        });
        
        it(@"should send a request with the correct parameterts", ^{
            parameters should equal(@{@"email": @"testemail@berkeley.edu",
                                      @"password": @"password",});
        });
        
        it(@"should leave progress as nil", ^{
            progress should be_nil;
        });
        
        //        context(@"when the user/password is valid and the request succeeds", ^{
        //            __block NSURLSessionTask *operation;
        //            __block NSHTTPURLResponse *theResponse;
        //            beforeEach(^{
        //                operation = nice_fake_for([NSURLSessionTask class]);
        //                theResponse = nice_fake_for([NSHTTPURLResponse class]);
        //
        //                operation stub_method(@selector(response))
        //                .and_do_block(^NSHTTPURLResponse* () {return theResponse;});
        //
        //                theResponse stub_method(@selector(allHeaderFields))
        //                .and_do_block(^NSDictionary* () {return @{@"access-token": @"new-token"};});
        //
        //                // seems like relevant issue: http://stackoverflow.com/questions/32462929/nsurlsessiondatatask-response-unrecognized-selector-crash-in-ios-9
        //
        //                simulateSuccess(operation, nil);
        //            });
        //
        //            it(@"should update the auth token", ^{
        //                subject.token should equal(@"new-token");
        //            });
        //
        //            it(@"should call the SuccessBlock", ^{
        //                successBlockCalled should be_truthy;
        //            });
        //        });
        
        context(@"when the user/password is invalid and the request fails", ^{
            beforeEach(^{
                NSError *error = nice_fake_for([NSError class]);
                simulateFailure(nil, error);
            });
            
            it(@"should not update the auth token", ^{
                subject.token should be_empty;
            });
            
            it(@"should call the FailureBlock", ^{
                failureBlockCalled should be_truthy;
            });
        });
    });
    
    // LOCATION
    describe(@"-updateLocation:SucessBlock:FailureBlock:", ^{
        
    });
    
    // COMMUNITIES
    describe(@"-fetchCommunitiesWithSuccessBlock:FailureBlock", ^{
        
    });
    
    describe(@"createCommunityWithName:PrivacyLevel:SuccessBlockFailureBlock:", ^{
        
    });
    
    // PEERS
    describe(@"-fetchPeersWithSuccessBlock:FailureBlock", ^{
        __block NSString *urlString;
        __block NSDictionary *parameters;
        __block void (^progress)(NSProgress *);
        __block void (^simulateSuccess)(NSURLSessionTask *, id);
        __block void (^simulateFailure)(NSURLSessionTask *, NSError *);
        
        beforeEach(^{
            urlString = nil;
            parameters = nil;
            progress = nil;
            simulateSuccess = nil;
            simulateFailure = nil;
            successBlockCalled = false;
            failureBlockCalled = false;
            manager stub_method("GET:parameters:progress:success:failure:")
            .and_do_block(^id (
                               NSString *incomingURLString,
                               NSDictionary *incomingParameters,
                               void (^incomingProgress)(NSProgress *),
                               void (^incomingSuccessHandler)(NSURLSessionTask *, id),
                               void (^incomingFailureHandler)(NSURLSessionTask *, NSError *)
                               )
                          {
                              urlString = incomingURLString;
                              parameters = incomingParameters;
                              progress = incomingProgress;
                              simulateSuccess = incomingSuccessHandler;
                              simulateFailure = incomingFailureHandler;
                              // made need a wait here to make sure tests can do assertions in
                              // correct order given there are multiple queries
                              return 0;
                          });
            
            [subject fetchPeersWithSuccessBlock:^void(NSArray *){successBlockCalled = true;}
                                   FailureBlock:^void(){failureBlockCalled = true;}];
        });
        
        it(@"should make the right requests", ^{
            urlString should equal(@"/users/1/groups/");
            urlString should equal(@"/groups/1/users");
            urlString should equal(@"/groups/2/users");
        });
        
        it(@"should leave parameters and progress as nil", ^{
            parameters should be_nil;
            progress should be_nil;
        });
        
        context(@"when the backend client returns groups", ^{
            context(@"when the backend client returns users for all groups", ^{
                
            });
            
            context(@"when the backend client errors on users for only one group", ^{
                
            });
            
            context(@"when the backend client errors on users for all groups", ^{
                
            });
        });
        
        context(@"when the backend client returns an error for getting groups", ^{
            
        });
        
    });
});

SPEC_END
