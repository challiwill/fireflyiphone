#import "AppDelegate.h"
#import "SignInController.h"
#import "FireflyClient.h"
#import "SessionManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    CGRect frame = [[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame:frame];
    
    //TODO update baseURL for prod
    NSURL *baseURL = [[NSURL alloc] initWithString:@"https://127.0.0.1:3001"];
    SessionManager *manager = [[SessionManager alloc] initWithBaseURL:baseURL];
    
    FireflyClient *backendClient = [[FireflyClient alloc] initWithManager:manager];
    
    self.window.rootViewController = [[SignInController alloc] initWithBackendClient:backendClient];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
