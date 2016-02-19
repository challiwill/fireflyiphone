#import "FireflyClient.h"

@interface FireflyClient ()

@property (nonatomic) NSString *token;
@property (nonatomic) NSString *client;
@property (nonatomic) NSString *expiry;
@property (nonatomic) NSString *uid;

@property (nonatomic) NSString *email;
@property (nonatomic) NSString *userID;
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

- (void)signUpWithUsername:(NSString *)username
                  Password:(NSString *)password
              SuccessBlock:(void (^)())successBlock
              FailureBlock:(void (^)())failureBlock
{
    NSDictionary *params = @{@"email": username, @"password": password};
    
    [self.manager POST:@"/auth"
            parameters:params
               success:^(NSURLSessionTask *operation, id responseObject)
     {
         if (operation.response != nil) {
             NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
             self.token = [response.allHeaderFields objectForKey:@"access-token"];
             self.client = [response.allHeaderFields objectForKey:@"client"];
             self.expiry = [response.allHeaderFields objectForKey:@"expiry"];
             self.uid = [response.allHeaderFields objectForKey:@"uid"];
             
             NSLog(@"signed up");
         }
         if([responseObject isKindOfClass:[NSDictionary class]])
         {
             NSDictionary *results = responseObject;
             self.userID = [[results objectForKey:@"data"] objectForKey:@"id"];
         } else {
             // TODO not sure
         }
         return successBlock();
     }
               failure:^(NSURLSessionTask *operation, NSError *error)
     {
         //TODO give more useful error on sign up failure
         NSLog(@"failed to sign up");
         NSLog(@"ERROR: %@", error);
         return failureBlock();
     }];
    
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
         if (operation.response != nil) {
             NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
             self.token = [response.allHeaderFields objectForKey:@"access-token"];
             self.client = [response.allHeaderFields objectForKey:@"client"];
             self.expiry = [response.allHeaderFields objectForKey:@"expiry"];
             self.uid = [response.allHeaderFields objectForKey:@"uid"];
             
             NSLog(@"signed in");
         }
         if([responseObject isKindOfClass:[NSDictionary class]])
         {
             NSDictionary *results = responseObject;
             self.userID = [[results objectForKey:@"data"] objectForKey:@"id"];
         } else {
             // TODO not sure
         }
         return successBlock();
     }
               failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"failed to sign in");
         NSLog(@"ERROR: %@", error);
         return failureBlock();
     }];
}

- (void)updateLocation:(CLLocation *)newLocation
          SuccessBlock:(void (^)())successBlock
          FailureBlock:(void (^)())failureBlock;
{
    [self prepareHeader];
    
    NSString *patchPath = [NSString stringWithFormat: @"/users/%@", self.userID];
    NSNumber *latitude = @(newLocation.coordinate.latitude);
    NSNumber *longitude = @(newLocation.coordinate.longitude);
    NSDictionary *params = @{@"user": @{@"latitude":latitude, @"longitude":longitude}};
    
    [self.manager PATCH:patchPath
             parameters:params
                success:nil
                failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"failed to update location");
         NSLog(@"ERROR: %@", error);
         return failureBlock();
     }];
}

- (void)fetchCommunitiesWithSuccessBlock:(void (^)(NSArray *))successBlock
                            FailureBlock:(void (^)())failureBlock
{
    [self prepareHeader];
    
    NSString *groupsPath = [NSString stringWithFormat: @"/users/%@/groups", self.userID];
    // TODO add logging
    [self.manager GET:groupsPath
           parameters:nil
             progress:nil
              success:^(NSURLSessionTask *operation, id responseObject)
     {
         NSArray *groups;
         if([responseObject isKindOfClass:[NSDictionary class]])
         {
             NSDictionary *results = responseObject;
             groups = [results objectForKey:@"groups"];
         } else {
             // TODO not sure
         }
         return successBlock(groups);
     }
              failure:^(NSURLSessionTask *operation, NSError *error){return failureBlock();}
     ];
}

- (void)prepareHeader
{
    [self.manager.requestSerializer setValue:self.token forHTTPHeaderField:@"access-token"];
    [self.manager.requestSerializer setValue:@"Bearer" forHTTPHeaderField:@"token-type"];
    [self.manager.requestSerializer setValue:self.client forHTTPHeaderField:@"client"];
    [self.manager.requestSerializer setValue:self.expiry forHTTPHeaderField:@"expiry"];
    [self.manager.requestSerializer setValue:self.uid forHTTPHeaderField:@"uid"];
}

- (void)reportLocationUpdateError
{
    //TODO implement error alert
}

@end
