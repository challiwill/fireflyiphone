#import <Foundation/Foundation.h>

@interface Peer : NSObject

@property (nonatomic, readonly) NSString *name;

- (instancetype)initWithName: (NSString *) name;

@end
