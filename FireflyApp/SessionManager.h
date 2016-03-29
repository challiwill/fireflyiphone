#import <Foundation/Foundation.h>

@interface SessionManager : NSObject

@property (nonatomic, readonly) NSURL *baseURL;
@property (nonatomic, readonly) NSString *token;

- (instancetype)initWithBaseURL:(NSURL *)baseURL;

- (void) POST:(NSString *)url
   parameters:(NSDictionary *)parameters
      success: (void (^)(NSURLSessionDataTask *task, id responseObject))success
      failure: (void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) PATCH:(NSString *)url
   parameters:(NSDictionary *)parameters
      success: (void (^)(NSURLSessionDataTask *task, id responseObject))success
      failure: (void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) GET:(NSString *)url
   parameters:(NSDictionary *)parameters
      success: (void (^)(NSURLSessionDataTask *task, id responseObject))success
      failure: (void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
