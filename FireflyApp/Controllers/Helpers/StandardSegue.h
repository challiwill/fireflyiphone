#import <UIKit/UIKit.h>

@interface StandardSegue : UIStoryboardSegue

- (instancetype)initWithIdentifier:(NSString *)identifier
                            source:(UIViewController *)source
                       destination:(UIViewController *)destination;

- (void)perform;

@end
