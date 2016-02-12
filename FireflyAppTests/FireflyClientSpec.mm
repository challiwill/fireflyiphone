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
    
    describe(@"-signInWithUsername:Password:SuccessBlock:FailureBlock:", ^{
        __block NSString *urlString;
        __block NSDictionary *parameters;
        __block void (^simulateSuccess)(NSURLSessionTask *, id);
        __block void (^simulateFailure)(NSURLSessionTask *, NSError *);
        
        beforeEach(^{
            urlString = nil;
            parameters = nil;
            simulateSuccess = nil;
            simulateFailure = nil;
            successBlockCalled = false;
            failureBlockCalled = false;
            manager stub_method("POST:parameters:success:failure:")
            .and_do_block(^id (
                               NSString *incomingURLString,
                               NSDictionary *incomingParameters,
                               void (^incomingSuccessHandler)(NSURLSessionTask *, id),
                               void (^incomingFailureHandler)(NSURLSessionTask *, NSError *)
                               )
                          {
                              urlString = incomingURLString;
                              parameters = incomingParameters;
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
        
        context(@"when the user/password is valid and the request succeeds", ^{
            __block NSURLSessionTask *operation;
            __block NSHTTPURLResponse *response;
            beforeEach(^{
                operation = nice_fake_for([NSURLSessionTask class]);
                response = nice_fake_for([NSHTTPURLResponse class]);
                
                
                //
                //                operation stub_method("response")
                //                .and_do_block(^NSHTTPURLResponse* () {return response;});
                //
                //                response stub_method(@selector(allHeaderFields))
                //                .and_do_block(^NSDictionary* () {return @{@"access-token": @"new-token"};});
                
                //                operation.response = response;
                //                response.allHeaderFields = @{@"access-token": @"new-token"};
                
                simulateSuccess(operation, nil);
            });
            
            it(@"should update the auth token", ^{
                subject.token should equal(@"new-token");
            });
            
            it(@"should call the SuccessBlock", ^{
                successBlockCalled should be_truthy;
            });
        });
        
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
});

SPEC_END
