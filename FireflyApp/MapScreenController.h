#import <UIKit/UIKit.h>
#import "FireflyClient.h"

@interface MapScreenController: UIViewController

@property (nonatomic, readonly) FireflyClient *backendClient;

- (instancetype)initWithBackendClient:(FireflyClient *)backendClient;

@end
