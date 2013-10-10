#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
@protocol GCHelperDelegate
- (void)matchStarted;
- (void)matchEnded;
- (void)match:(GKMatch *)match didReceiveData:(NSData *)data
   fromPlayer:(NSString *)playerID;
@end

@interface GCHelper : NSObject <GKMatchmakerViewControllerDelegate, GKMatchDelegate> {
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
    UIViewController *presentingViewController;
    GKMatch *match;
    BOOL matchStarted;
    id <GCHelperDelegate> _unsafe_retained_delegate;
    NSMutableDictionary *playersDict;
}

@property (assign, readonly) BOOL gameCenterAvailable;

@property (retain) NSMutableDictionary *playersDict;

+ (GCHelper *)sharedInstance;
- (void)authenticateLocalUser;

@property (retain) UIViewController *presentingViewController;
@property (retain) GKMatch *match;
@property (assign) id <GCHelperDelegate> delegate;

- (void)findMatchWithMinPlayers:(int)minPlayers maxPlayers:(int)maxPlayers
                 viewController:(UIViewController *)viewController
                       delegate:(id<GCHelperDelegate>)theDelegate;

@end