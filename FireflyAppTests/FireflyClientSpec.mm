#import "Cedar.h"
#import "FireflyClient.h"
#import "AFHTTPRequestOperationManager.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(FireflyClientSpec)

fdescribe(@"FireflyClient", ^{
    __block FireflyClient *subject;
    __block AFHTTPRequestOperationManager *manager;
    
    
    beforeEach(^{
        manager = nice_fake_for([AFHTTPRequestOperationManager class]);
        subject = [[FireflyClient alloc] initWithManager:manager];
    });
    
    describe(@"-signInWithUsername:Password:SuccessBlock:FailureBlock:", ^{
        __block NSString *urlString;
        __block NSDictionary *parameters;
        __block void (^simulateSuccess)(AFHTTPRequestOperation *, id);
        __block void (^simulateFailure)(AFHTTPRequestOperation *, NSError *);
        
        beforeEach(^{
            urlString = nil;
            parameters = nil;
            simulateSuccess = nil;
            simulateFailure = nil;
            manager stub_method(@selector(POST:parameters:success:failure:))
            .and_do_block(^id (
                                 NSString *incomingURLString,
                                 NSDictionary *incomingParameters,
                                 void (^incomingSuccessHandler)(AFHTTPRequestOperation *, id),
                                 void (^incomingFailureHandler)(AFHTTPRequestOperation *, NSError *)
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
                           SuccessBlock:^void(){NSLog(@"GREAT-SUCCESS");}
                           FailureBlock:^void(){NSLog(@"GREAT-FAILURE");}];
        });
        
        it(@"should send a request to the correct URL", ^{
            urlString should equal(@"/auth/sign_in");
        });
        
        it(@"should send a request with the correct parameterts", ^{
            parameters should equal(@{@"email": @"testemail@berkeley.edu",
                        @"password": @"password",});
        });
        
        context(@"when the user/password is valid and the request succeeds", ^{
            __block AFHTTPRequestOperation *operation;
            __block NSHTTPURLResponse *response;
            beforeEach(^{
                operation = nice_fake_for([AFHTTPRequestOperation class]);
                response = nice_fake_for([NSHTTPURLResponse class]);
                
                operation stub_method(@selector(response))
                .and_do_block(^NSHTTPURLResponse* () {return response;});
                
                response stub_method(@selector(allHeaderFields))
                .and_do_block(^NSDictionary* () {return @{@"access-token": @"new-token"};});
                
                simulateSuccess(operation, nil);
            });
            
            it(@"should update the auth token", ^{
                subject.token should equal(@"new-token");
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
        });
    });
});

SPEC_END
