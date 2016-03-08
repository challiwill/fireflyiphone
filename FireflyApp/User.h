#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, readonly) NSString *uid;
@property (nonatomic, readonly) NSString *name;

- (instancetype)initWithName:(NSString *)name ID:(NSString *)uid;

@end
