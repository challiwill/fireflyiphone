#import "CommunityListController.h"

@interface CommunityListController ()

@property (nonatomic) FireflyClient *backendClient;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) CommunityListDataSourceDelegate *tableViewDataSourceDelegate;

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
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 800)];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300, 800)];
    [self.view addSubview:self.tableView];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    self.tableViewDataSourceDelegate = [[CommunityListDataSourceDelegate alloc] init];
    self.tableView.dataSource = self.tableViewDataSourceDelegate;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:communityCellIdentifier];
    
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

@end
