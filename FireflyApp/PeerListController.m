#import "PeerListController.h"

@interface PeerListController ()

@property (nonatomic) FireflyClient *backendClient;
@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) PeerListDataSourceDelegate *tableViewDataSourceDelegate;
// TODO need to set user on initialization
@property (nonatomic) User *user;

@end

@implementation PeerListController

- (instancetype)initWithBackendClient:(FireflyClient *)backendClient LocationManager:(CLLocationManager *)locationManager
{
    self = [super init];
    if (self) {
        self.backendClient = backendClient;
        self.locationManager = locationManager;
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
    self.tableViewDataSourceDelegate = [[PeerListDataSourceDelegate alloc] init];
    self.tableView.dataSource = self.tableViewDataSourceDelegate;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:peerCellIdentifier];
    [self.backendClient fetchPeersForUser:self.user
                             SuccessBlock:^void (NSArray *peers) {
                                 [self.tableViewDataSourceDelegate configureWithPeers:peers];
                                 [self.tableView reloadData];
                             }
                             FailureBlock:^void (NSError *error) {
                                 [self displayError:error];
                             }];
}

- (void)displayError:(NSError *)error
{
    
}

@end