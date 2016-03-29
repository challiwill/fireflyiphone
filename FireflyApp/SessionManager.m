#import "SessionManager.h"

@interface SessionManager ()

@property (nonatomic) NSURL *baseURL;
@property (nonatomic) NSString *token;

@end

@implementation SessionManager

- (instancetype)initWithBaseURL:(NSURL *)baseURL
{
    self = [super init];
    if (self) {
        self.baseURL = baseURL;
    }
    return self;
}

- (void) POST:(NSString *)url
   parameters:(NSDictionary *)parameters
      success: (void (^)(NSURLSessionDataTask *task, id responseObject))success
failure: (void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    // call this directly on a NSURLSessionDataTask?
    return;
}


- (void) PATCH:(NSString *)url
    parameters:(NSDictionary *)parameters
       success: (void (^)(NSURLSessionDataTask *task, id responseObject))success
       failure: (void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    return;
}

- (void) GET:(NSString *)url
  parameters:(NSDictionary *)parameters
     success: (void (^)(NSURLSessionDataTask *task, id responseObject))success
     failure: (void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    return;
}

@end
