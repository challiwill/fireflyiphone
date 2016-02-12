#import "FireflyClient.h"

@interface FireflyClient ()

@property (nonatomic) NSString *token;
@property (nonatomic) NSString *email;
@property (nonatomic) AFHTTPSessionManager *manager;

@end

@implementation FireflyClient

- (instancetype)initWithManager:(AFHTTPSessionManager *)manager
{
    self = [super init];
    if (self) {
        self.manager = manager;
        self.manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        [self.manager.securityPolicy setValidatesDomainName:NO];
        [self.manager.securityPolicy setAllowInvalidCertificates:YES];
        [self.manager.securityPolicy setValidatesDomainName:NO];
    }
    
    return self;
}

- (void)signInWithUsername:(NSString *)username
                  Password:(NSString *)password
              SuccessBlock:(void (^)())successBlock
              FailureBlock:(void (^)())failureBlock;
{
    NSDictionary *params = @{@"email": username, @"password": password};
    
    [self.manager POST:@"/auth/sign_in"
            parameters:params
            success:^(NSURLSessionTask *operation, id responseObject)
     {
         // TODO remove log statements or update to not leak tokens
         NSLog(@"before checking response");

         if (operation.response != nil) {
             NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
             self.token = [response.allHeaderFields objectForKey:@"access-token"];
             NSLog(@"signed in");
             NSLog(@"received TOKEN: %@", self.token);
         }
         NSLog(@"JSON: %@", responseObject);
         return successBlock();
     }
               failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"failed to sign in");
         NSLog(@"ERROR: %@", error);
         return failureBlock();
     }];
}

@end
