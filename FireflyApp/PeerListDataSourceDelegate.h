#import <UIKit/UIKit.h>

extern NSString *const peerCellIdentifier;

@interface PeerListDataSourceDelegate : NSObject <UITableViewDataSource, UITableViewDelegate>

- (void)configureWithPeers:(NSArray *) peers;

@end
