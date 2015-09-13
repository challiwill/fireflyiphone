#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) FireflyClient *backendClient;

@end

@implementation ViewController

- (instancetype)initWithBackendClient:(FireflyClient *)backendClient
{
    self = [super init];
    if (self) {
        self.backendClient = backendClient;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
