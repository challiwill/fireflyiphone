#import "AppDelegate.h"
#import "SignInController.h"
#import "FireflyClient.h"
#import "AFHTTPRequestOperationManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    CGRect frame = [[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame:frame];
    
    //TODO update baseURL for prod
    NSURL *baseURL = [[NSURL alloc] initWithString:@"https://0.0.0.0:3001"];
    AFHTTPRequestOperationManager *manager =
        [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    [manager setOperationQueue:queue];
    
    FireflyClient *backendClient = [[FireflyClient alloc] initWithManager:manager];
    
    self.window.rootViewController = [[SignInController alloc] initWithBackendClient:backendClient];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
