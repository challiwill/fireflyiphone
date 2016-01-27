#import "SignInController.h"
#import "MapScreenController.h"
#import "StandardSegue.h"
#import "Mapbox/Mapbox.h"

@interface SignInController ()

@property (nonatomic) FireflyClient *backendClient;
@property (nonatomic) UITextField *emailField;
@property (nonatomic) UITextField *passwordField;
@property (nonatomic) UIButton *signInButton;

@end

@implementation SignInController


- (instancetype)initWithBackendClient:(FireflyClient *)backendClient
{
    self = [super init];
    if (self) {
        self.backendClient = backendClient;
    }
    return self;
}


#pragma mark - UIViewController

- (void)loadView
{
    // TODO determine frames sizing and positioning
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 800)];
    self.emailField = [[UITextField alloc] initWithFrame:CGRectMake(35, 400, 300, 50)];
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(35, 465, 300, 50)];
    self.signInButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [self.view addSubview:self.emailField];
    [self.view addSubview:self.passwordField];
    [self.view addSubview:self.signInButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor darkGrayColor];

    self.emailField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordField.borderStyle = UITextBorderStyleRoundedRect;

    self.emailField.placeholder = @"email";
    self.passwordField.placeholder = @"password";
    self.passwordField.secureTextEntry = YES;
    [self.signInButton setTitle:@"Sign in!" forState:UIControlStateNormal];
    [self.signInButton addTarget:self action:@selector(signIn) forControlEvents:UIControlEventTouchUpInside];
    self.signInButton.frame = CGRectMake(140, 520, 75, 50);
}

- (void)signIn
{
    self.emailField.text = @"testemail@berkeley.edu";
    self.passwordField.text = @"password";
    // TODO some level of checks on user/password here (at least not empty)?
    [self.backendClient signInWithUsername:self.emailField.text
                                  Password:self.passwordField.text
                              SuccessBlock:^void () {[self segueToMapScreen];}
                              FailureBlock:^void () {NSLog(@"Login failed");}];
}

- (void)segueToMapScreen
{
    MGLMapView *mapView = [[MGLMapView alloc] initWithFrame:self.view.bounds];
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    MapScreenController *mapScreenController = [[MapScreenController alloc]
                                                initWithBackendClient:self.backendClient
                                                LocationManager:locationManager
                                                andMapView:mapView];
    StandardSegue *segue = [[StandardSegue alloc]
                                initWithIdentifier:@"signInToMapScreen"
                                            source:self
                                       destination:mapScreenController];
    [self prepareForSegue:segue sender:self];
    [segue perform];
}
@end
