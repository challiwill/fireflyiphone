#import "Peer.h"

@interface Peer ()

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *userID;

@end

@implementation Peer

- (instancetype)initWithName:(NSString *)name ID:(NSString *)userID
{
    self = [super init];
    if (self) {
        self.name = name;
        self.userID = userID;
    }
    return self;
}

@end
