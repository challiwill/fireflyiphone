#import "Cedar.h"
#import "FireflyClient.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(FireflyClientSpec)

describe(@"FireflyClient", ^{
    __block FireflyClient *subject;
    __block NSURLSession<CedarDouble> *urlSession;
    __block void (^requestCompletionHandler)(NSData *, NSURLResponse *, NSError *);
    __block void (^operationQueueBlock)();
    
    __block NSURLRequest *request;
    __block NSOperationQueue *mainQueue;
    
    beforeEach(^{
        urlSession = nice_fake_for([NSURLSession class]);
        mainQueue = nice_fake_for([NSOperationQueue class]);
        mainQueue stub_method(@selector(addOperationWithBlock:)).and_do_block(^void (void (^callback)()) {
            operationQueueBlock = callback;
        });
        
        subject = [[FireflyClient alloc] initWithUrlSession:urlSession andOperationQueue:mainQueue];
        urlSession stub_method(@selector(dataTaskWithRequest:completionHandler:))
        .and_do_block(^id (NSURLRequest *incomingRequest, void (^incomingRequestCompletionHandler)(NSData *, NSURLResponse *, NSError *)) {
            request = incomingRequest;
            requestCompletionHandler = incomingRequestCompletionHandler;
            return nil;
        });
    });
    
    
});

SPEC_END
