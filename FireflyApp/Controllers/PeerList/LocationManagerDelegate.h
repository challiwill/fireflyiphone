#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "FireflyClient.h"
#import "User.h"

@class FireflyClient;

@interface LocationManagerDelegate: NSObject <CLLocationManagerDelegate>

@property (nonatomic, readonly) FireflyClient *backendClient;

- (instancetype)initWithBackendClient:(FireflyClient *)backendClient
                                 User:(User *)user;
@end
