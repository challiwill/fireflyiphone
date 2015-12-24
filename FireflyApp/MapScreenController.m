#import "MapScreenController.h"
#import "FireflyClient.h"

@interface MapScreenController ()

@property (nonatomic) FireflyClient *backendClient;

@end

@implementation MapScreenController


- (instancetype)initWithBackendClient:(FireflyClient *)backendClient
{
    self = [super init];
    if (self) {
        self.backendClient = backendClient;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
}

@end
