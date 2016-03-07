#import "Peer.h"

@interface Peer ()

@property (nonatomic) NSString *name;

@end

@implementation Peer

- (instancetype)initWithName: (NSString *) name
{
    self = [super init];
    if (self) {
        self.name = name;
    }
    return self;
}

@end
