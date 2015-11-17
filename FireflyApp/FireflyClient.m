#import "FireflyClient.h"
#import "AFNetworking.h"

@interface FireflyClient ()

@property (nonatomic) NSString *token;
@property (nonatomic) NSString *email;
@property (nonatomic) AFHTTPRequestOperationManager *manager;

@end

@implementation FireflyClient

- (instancetype)initWithManager:(AFHTTPRequestOperationManager *)manager
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
               success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (operation.response != nil) {
             self.token = [operation.response.allHeaderFields objectForKey:@"access-token"];
             NSLog(@"TOKEN: %@", self.token);
         }
         NSLog(@"JSON: %@", responseObject);
     }
               failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"ERROR: %@", error);
     }];
}

@end
