#import "AddCommunityController.h"

@interface AddCommunityController ()

@property (nonatomic) FireflyClient *backendClient;
@property (nonatomic) User *user;
@property (nonatomic) UITextField *communityName;
@property (nonatomic) UITextField *communityDescription;
// TODO should it be a radio button with privacy options?
@property (nonatomic) UISwitch *communityPrivate;
@property (nonatomic) UIButton *createCommunityButton;
@property (nonatomic) UIButton *cancelButton;

@end

@implementation AddCommunityController

- (instancetype)initWithBackendClient:(FireflyClient *)backendClient User:(User *)user
{
    self = [super init];
    if (self) {
        self.backendClient = backendClient;
        self.user = user;
    }
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 800)];
    
    self.communityName = [[UITextField alloc] initWithFrame:CGRectMake(50, 200, 200, 20)];
    self.communityDescription = [[UITextField alloc] initWithFrame:CGRectMake(50, 400, 200, 20)];
    self.communityPrivate = [[UISwitch alloc] init];
    
    [self.view addSubview:self.communityName];
    [self.view addSubview:self.communityDescription];
    [self.view addSubview:self.communityPrivate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    self.communityPrivate.center = CGPointMake(100, 600);
    
    self.communityName.borderStyle = UITextBorderStyleRoundedRect;
    self.communityDescription.borderStyle = UITextBorderStyleRoundedRect;
}

- (void)cancel
{
    [self segueToCommunityList:self.user];
}

- (void)createCommunity
{
    // TODO
    //    [self.backendClient createCommunity];
}

- (void)segueToCommunityList:(User *)user
{
    CommunityListController *communityListController = [[CommunityListController alloc] initWithBackendClient:self.backendClient User:user];
    
    StandardSegue *segue = [[StandardSegue alloc]
                            initWithIdentifier:@"addCommunityToCommunityList"
                            source:self
                            destination:communityListController];
    [self prepareForSegue:segue sender:self];
    [segue perform];
}

@end
