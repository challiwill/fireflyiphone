#import <Foundation/Foundation.h>

@interface Community : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *cid;

- (instancetype)initWithId:(NSString *)cid Name:(NSString *)name;

@end
