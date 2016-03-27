#import "StandardSegue.h"

@implementation StandardSegue

- (instancetype)initWithIdentifier:(NSString *)identifier
                            source:(UIViewController *)source
                       destination:(UIViewController *)destination
{
    return [super initWithIdentifier:identifier source:source destination:destination];
}

- (void)perform
{
    // Add your own animation code here.
    [[self sourceViewController] presentViewController:[self destinationViewController] animated:NO completion:nil];
}

@end
