#import <Cedar/Cedar.h>
#import "PeerListController.h"
#import "Peer.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(PeerListControllerSpec)

describe(@"PeerListController", ^{
    __block PeerListController *subject;
    __block FireflyClient *backendClient;
    __block CLLocationManager *locationManager;
    __block User *user;
    
    beforeEach(^{
        backendClient = nice_fake_for([FireflyClient class]);
        locationManager = nice_fake_for([CLLocationManager class]);
        user = nice_fake_for([User class]);
        
        subject = [[PeerListController alloc] initWithBackendClient:backendClient
                                                    LocationManager:locationManager
                                                               User:user];
    });
    
    it(@"initializes with properties set", ^{
        subject.backendClient should equal(backendClient);
        subject.locationManager should equal(locationManager);
    });
    
    describe(@"-viewDidLoad", ^{
        __block void (^successBlock)(NSArray *);
        __block void (^failureBlock)(NSArray *);
        
        beforeEach(^{
            backendClient stub_method(@selector(fetchPeersForUser:SuccessBlock:FailureBlock:)).and_do_block(^void (User *incomingUser, void (^incomingSuccessBlock)(NSArray *), void(^incomingFailureBlock)(NSArray *)){
                successBlock = incomingSuccessBlock;
                failureBlock = incomingFailureBlock;
            });
            subject.view should_not be_nil;
        });
        
        it(@"should fetch a list of peers from the backend client", ^{
            backendClient should have_received(@selector(fetchPeersForUser:SuccessBlock:FailureBlock:));
        });
        
        context(@"when the backend client returns the list of peers successfully", ^{
            beforeEach(^{
                Peer *peer = [[Peer alloc] initWithName:@"Bob" ID:@"1"];
                Peer *peer2 = [[Peer alloc] initWithName:@"Alice" ID:@"2"];
                if(successBlock) {
                    successBlock(@[peer, peer2]);
                }
                else{
                    fail(@":(");
                }
            });
            
            it(@"should show the peer on a table view", ^{
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                UITableViewCell *cell = [subject.tableView.dataSource tableView:subject.tableView cellForRowAtIndexPath:indexPath];
                cell.textLabel.text should equal(@"Bob");
            });
            
            it(@"should show a cell for each peer", ^{
                NSInteger numberOfCells = [subject.tableView.dataSource tableView:subject.tableView numberOfRowsInSection:0];
                numberOfCells should equal(2);
            });
        });
    });
});

SPEC_END
