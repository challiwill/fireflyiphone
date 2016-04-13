#import "SignUpController.h"
#import "CommunityListController.h"

@interface SignUpController ()

@property (nonatomic) FireflyClient *backendClient;
@property (nonatomic) UITextField *emailField;
@property (nonatomic) UITextField *passwordField;
// TODO add profile picture
@property (nonatomic) UIButton *signUpButton;
@property (nonatomic) UIButton *cancelButton;


@end

@implementation SignUpController

- (instancetype)initWithBackendClient:(FireflyClient *)backendClient
{
    self = [super init];
    if (self) {
        self.backendClient = backendClient;
    }
    return self;
}

- (void)loadView
{
    // TODO determine frames sizing and positioning
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 800)];
    self.emailField = [[UITextField alloc] initWithFrame:CGRectMake(35, 400, 300, 50)];
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(35, 465, 300, 50)];
    self.signUpButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [self.view addSubview:self.emailField];
    [self.view addSubview:self.passwordField];
    [self.view addSubview:self.signUpButton];
    [self.view addSubview:self.cancelButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    self.emailField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordField.borderStyle = UITextBorderStyleRoundedRect;
    
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    self.cancelButton.frame = CGRectMake(80, 520, 75, 50);
    
    self.emailField.placeholder = @"email";
    self.passwordField.placeholder = @"password";
    self.passwordField.secureTextEntry = YES;
    
    [self.signUpButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    [self.signUpButton addTarget:self action:@selector(signUp) forControlEvents:UIControlEventTouchUpInside];
    self.signUpButton.frame = CGRectMake(140, 520, 75, 50);
}

- (void)cancel
{
    SignInController *signInController = [[SignInController alloc]                                                initWithBackendClient:self.backendClient];
    StandardSegue *segue = [[StandardSegue alloc]
                            initWithIdentifier:@"signUpToSignIn"
                            source:self
                            destination:signInController];
    [self prepareForSegue:segue sender:self];
    [segue perform];
}

- (void)signUp
{
    [self signUpWithUsername:self.emailField.text
                    Password:self.passwordField.text
                SuccessBlock:^void (User *user) {[self segueToCommunityListController:user];}
                FailureBlock:^void () {NSLog(@"Sign Up failed");}];
}

- (void)signUpWithUsername:(NSString *)username Password:(NSString *)password SuccessBlock:(void (^)(User *))successBlock FailureBlock:(void (^)())failureBlock
{
    NSLog(@"Calling backend client");
    [self.backendClient signUpWithUsername:username
                                  Password:password
                              SuccessBlock:successBlock
                              FailureBlock:failureBlock];
    NSLog(@"Called backend client");
}

- (void)segueToCommunityListController:(User *)user
{
    CommunityListController *communityListController = [[CommunityListController alloc] initWithBackendClient:self.backendClient User:user];
    
    StandardSegue *segue = [[StandardSegue alloc]
                            initWithIdentifier:@"signUpToCommunityList"
                            source:self
                            destination:communityListController];
    [self prepareForSegue:segue sender:self];
    [segue perform];
}

@end
