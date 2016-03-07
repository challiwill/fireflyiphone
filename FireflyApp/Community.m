#import "Community.h"

@interface Community ()

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *cid;

@end

@implementation Community

- (instancetype)initWithId:(NSString *)cid Name:(NSString *)name
{
    self = [super init];
    if (self) {
        self.cid = cid;
        self.name = name;
    }
    return self;
}

@end
