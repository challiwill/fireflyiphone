#import "User.h"

@interface User()

@property (nonatomic) NSString *uid;
@property (nonatomic) NSString *name;

@end

@implementation User

- (instancetype)initWithName:(NSString *)name ID:(NSString *)uid
{
    self = [super init];
    if (self) {
        self.uid = uid;
        self.name = name;
    }
    return self;
}

@end
