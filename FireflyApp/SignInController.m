#import "SignInController.h"

@interface SignInController ()

@property (nonatomic) FireflyClient *backendClient;
@property (nonatomic) UITextField *emailField;
@property (nonatomic) UITextField *passwordField;
@property (nonatomic) UIButton *signInButton;
@property (nonatomic) UIButton *signUpButton;

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
    self.signUpButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [self.view addSubview:self.emailField];
    [self.view addSubview:self.passwordField];
    [self.view addSubview:self.signInButton];
    [self.view addSubview:self.signUpButton];
    
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
    [self.signInButton setTitle:@"Sign In" forState:UIControlStateNormal];
    [self.signInButton addTarget:self action:@selector(signIn) forControlEvents:UIControlEventTouchUpInside];
    self.signInButton.frame = CGRectMake(140, 520, 75, 50);
    
    [self.signUpButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    [self.signUpButton addTarget:self action:@selector(signUp) forControlEvents:UIControlEventTouchUpInside];
    self.signUpButton.frame = CGRectMake(80, 520, 75, 50);
    
}

- (void)signIn
{
    self.emailField.text = @"testemail@berkeley.edu";
    self.passwordField.text = @"password";
    // TODO some level of checks on user/password here (at least not empty)?
    [self.backendClient signInWithUsername:self.emailField.text
                                  Password:self.passwordField.text
                              SuccessBlock:^void (User *user) {[self segueToPeerList:user];}
                              FailureBlock:^void () {NSLog(@"Login failed");}];
}

- (void)segueToPeerList:(User *)user
{
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    PeerListController *peerListController = [[PeerListController alloc]
                                              initWithBackendClient:self.backendClient
                                              LocationManager:locationManager
                                              User:user];
    StandardSegue *segue = [[StandardSegue alloc]
                            initWithIdentifier:@"signInToPeerList"
                            source:self
                            destination:peerListController];
    [self prepareForSegue:segue sender:self];
    [segue perform];
}

- (void)signUp
{
    [self segueToSignUpScreen];
}

- (void)segueToSignUpScreen
{
    SignUpController *signUpController = [[SignUpController alloc]                                                initWithBackendClient:self.backendClient];
    StandardSegue *segue = [[StandardSegue alloc]
                            initWithIdentifier:@"signInToSignUp"
                            source:self
                            destination:signUpController];
    [self prepareForSegue:segue sender:self];
    [segue perform];
}
@end
