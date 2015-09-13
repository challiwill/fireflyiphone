#import "FireflyClient.h"

@interface FireflyClient ()

@property (nonatomic) NSURLSession *urlSession;
@property (nonatomic) NSOperationQueue *mainQueue;

@end

@implementation FireflyClient

- (instancetype)initWithUrlSession:(NSURLSession *)urlSession andOperationQueue:(NSOperationQueue *)mainQueue
{
    self = [super init];
    if (self) {
        self.urlSession = urlSession;
        self.mainQueue = mainQueue;
    }
    return self;
}

@end
