#import <Foundation/Foundation.h>

@interface Peer : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *userID;

- (instancetype)initWithName:(NSString *)name ID:(NSString *)userID;

@end
