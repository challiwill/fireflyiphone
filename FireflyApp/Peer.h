#import <Foundation/Foundation.h>

@interface Peer : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *uid;

- (instancetype)initWithName:(NSString *)name ID:(NSString *)uid;

@end
