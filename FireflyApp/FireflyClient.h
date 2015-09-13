#import <Foundation/Foundation.h>

@interface FireflyClient : NSObject

@property (nonatomic, readonly) NSURLSession *urlSession;
@property (nonatomic, readonly) NSOperationQueue *mainQueue;

- (instancetype) initWithUrlSession:(NSURLSession *)urlSession andOperationQueue:(NSOperationQueue *)mainQueue;

@end
