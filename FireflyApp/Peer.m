#import "Peer.h"

@interface Peer ()

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *uid;

@end

@implementation Peer

- (instancetype)initWithName:(NSString *)name ID:(NSString *)uid
{
    self = [super init];
    if (self) {
        self.name = name;
        self.uid = uid;
    }
    return self;
}

@end
