#import <Foundation/Foundation.h>
#import "AFNetworking/AFHTTPSessionManager.h"
#import "LocationManagerDelegate.h"

@interface FireflyClient : NSObject

@property (nonatomic, readonly) NSString *token;

- (instancetype)initWithManager:(AFHTTPSessionManager *)manager;

- (void)signUpWithUsername:(NSString *)username
                  Password:(NSString *)password
              SuccessBlock:(void (^)())successBlock
              FailureBlock:(void (^)())failureBlock;
- (void)signInWithUsername:(NSString *)username
                  Password:(NSString *)password
              SuccessBlock:(void (^)())successBlock
              FailureBlock:(void (^)())failureBlock;
- (void)updateLocation:(CLLocation *)newlocation
          SuccessBlock:(void (^)())successBlock
          FailureBlock:(void (^)())failureBlock;;
- (void)reportLocationUpdateError;

@end
