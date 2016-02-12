#import <Foundation/Foundation.h>
#import "AFNetworking/AFHTTPSessionManager.h"

@interface FireflyClient : NSObject

@property (nonatomic, readonly) NSString *token;

- (instancetype)initWithManager:(AFHTTPSessionManager *)manager;

- (void)signInWithUsername:(NSString *)username
                  Password:(NSString *)password
              SuccessBlock:(void (^)())successBlock
              FailureBlock:(void (^)())failureBlock;
@end
