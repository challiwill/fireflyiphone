#import <Foundation/Foundation.h>
#import "AFNetworking/AFHTTPSessionManager.h"
#import "LocationManagerDelegate.h"
#import "Community.h"
#import "Peer.h"

@interface FireflyClient : NSObject

@property (nonatomic, readonly) NSString *token;

- (instancetype)initWithManager:(AFHTTPSessionManager *)manager;

// USER
- (void)signUpWithUsername:(NSString *)username
                  Password:(NSString *)password
              SuccessBlock:(void (^)())successBlock
              FailureBlock:(void (^)())failureBlock;
- (void)signInWithUsername:(NSString *)username
                  Password:(NSString *)password
              SuccessBlock:(void (^)())successBlock
              FailureBlock:(void (^)())failureBlock;

// LOCATION
- (void)updateLocation:(CLLocation *)newlocation
          SuccessBlock:(void (^)())successBlock
          FailureBlock:(void (^)())failureBlock;

// COMMUNITIES
- (void)fetchCommunitiesWithSuccessBlock:(void (^)(NSArray *))successBlock
                            FailureBlock:(void (^)())failureBlock;
- (void) createCommunityWithName:(NSString *)name
                    PrivacyLevel:(NSNumber *)privacyLevel
                    SuccessBlock:(void (^)())successBlock
                    FailureBlock:(void (^)())failureBlock;

// PEERS
- (void)fetchPeersWithSuccessBlock:(void (^)(NSArray *))successBlock
                      FailureBlock:(void (^)())failureBlock;

@end
