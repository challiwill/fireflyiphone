#import "CommunityListDataSourceDelegate.h"

NSString *const communityCellIdentifier = @"CommunityCellIdentifier";

@interface CommunityListDataSourceDelegate ()

@property (nonatomic) NSArray *communities;

@end

@implementation CommunityListDataSourceDelegate

- (void)configureWithCommunities:(NSArray *)communities
{
    self.communities = communities;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.communities.count;
}

@end
