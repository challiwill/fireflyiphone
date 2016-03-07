#import "CommunityListController.h"

@interface CommunityListController ()

@property (nonatomic) FireflyClient *backendClient;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) CommunityListDataSourceDelegate *tableViewDataSourceDelegate;
@property (nonatomic) UIButton *addCommunityButton;

@end

@implementation CommunityListController

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
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 800)];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, 400, 800)];
    self.addCommunityButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.addCommunityButton];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    self.addCommunityButton.center = CGPointMake(350, 75);
    [self.addCommunityButton addTarget:self action:@selector(segueToAddCommunity)
                      forControlEvents:UIControlEventTouchUpInside];
    
    self.tableViewDataSourceDelegate = [[CommunityListDataSourceDelegate alloc] init];
    self.tableView.dataSource = self.tableViewDataSourceDelegate;
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:communityCellIdentifier];
    
    [self.backendClient fetchCommunitiesWithSuccessBlock:^void (NSArray *communities)
     {
         NSLog(@"successfuly got no communities");
         [self.tableViewDataSourceDelegate configureWithCommunities:communities];
         [self.tableView reloadData];
     }
                                            FailureBlock:^void ()
     {
         NSLog(@"failed to get communities");
     }];
}

- (void)segueToAddCommunity
{
    AddCommunityController *addCommunityController = [[AddCommunityController alloc]
                                                      initWithBackendClient:self.backendClient];
    StandardSegue *segue = [[StandardSegue alloc]
                            initWithIdentifier:@"communityListToAddCommunity"
                            source:self
                            destination:addCommunityController];
    [self prepareForSegue:segue sender:self];
    [segue perform];
}

@end
