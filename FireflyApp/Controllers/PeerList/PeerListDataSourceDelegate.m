#import "PeerListDataSourceDelegate.h"
#import "Peer.h"

NSString *const peerCellIdentifier = @"PeerCellIdentifier";

@interface PeerListDataSourceDelegate ()

@property (nonatomic) NSArray *peers;

@end

@implementation PeerListDataSourceDelegate

- (void)configureWithPeers:(NSArray *) peers
{
    self.peers = peers;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:peerCellIdentifier];
    
    long index = indexPath.row;
    Peer *peer = self.peers[index];
    
    cell.textLabel.text = peer.name;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.peers.count;
}

@end
