#import <Foundation/Foundation.h>

@class AFHTTPRequestOperationManager;

@interface FireflyClient : NSObject

@property (nonatomic, readonly) NSString *token;

- (instancetype)initWithManager:(AFHTTPRequestOperationManager *)manager;

- (void)signInWithUsername:(NSString *)username
                  Password:(NSString *)password
              SuccessBlock:(void (^)())successBlock
              FailureBlock:(void (^)())failureBlock;
@end
