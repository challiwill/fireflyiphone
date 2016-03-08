#import <Foundation/Foundation.h>
#import "AFNetworking/AFHTTPSessionManager.h"
#import "LocationManagerDelegate.h"
#import "Community.h"
#import "Peer.h"
#import "User.h"

@interface FireflyClient : NSObject

@property (nonatomic, readonly) NSString *token;

- (instancetype)initWithManager:(AFHTTPSessionManager *)manager;

// USER
- (void)signUpWithUsername:(NSString *)username
                  Password:(NSString *)password
              SuccessBlock:(void (^)(User *))successBlock
              FailureBlock:(void (^)())failureBlock;
- (void)signInWithUsername:(NSString *)username
                  Password:(NSString *)password
              SuccessBlock:(void (^)(User *))successBlock
              FailureBlock:(void (^)())failureBlock;

// LOCATION
- (void)updateLocation:(CLLocation *)newlocation
               ForUser:(User *)user
          SuccessBlock:(void (^)())successBlock
          FailureBlock:(void (^)())failureBlock;

// COMMUNITIES
- (void)fetchCommunitiesForUser:(User *)user
                   SuccessBlock:(void (^)(NSArray *))successBlock
                   FailureBlock:(void (^)())failureBlock;
- (void) createCommunityForUser:(User *)user
                           Name:(NSString *)name
                   PrivacyLevel:(NSNumber *)privacyLevel
                   SuccessBlock:(void (^)())successBlock
                   FailureBlock:(void (^)())failureBlock;

// PEERS
- (void)fetchPeersForUser:(User *)user
             SuccessBlock:(void (^)(NSArray *))successBlock
             FailureBlock:(void (^)())failureBlock;

@end
