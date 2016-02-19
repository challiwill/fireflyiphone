#import <UIKit/UIKit.h>

extern NSString *const communityCellIdentifier;

@interface CommunityListDataSourceDelegate : NSObject <UITableViewDataSource, UITableViewDelegate>

- (void)configureWithCommunities:(NSArray *)communities;

@end
