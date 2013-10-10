//
//  rootMultiplayerViewController.m
//  Tapple
//
//  Created by Jed on 05/10/2013.
//  Copyright (c) 2013 Jed. All rights reserved.
//

#import "rootMultiplayerViewController.h"
#import <GameKit/GameKit.h>

@interface rootMultiplayerViewController ()

@end

@implementation rootMultiplayerViewController

@synthesize targetApples;
@synthesize selectedTime;

-(void)setGameState:(GameState)state {
    GameState gameState;
    gameState = state;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    hostSelected = NO;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[GCHelper sharedInstance] findMatchWithMinPlayers:2 maxPlayers:2 viewController:self delegate:self];
    ourRandom = arc4random();
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sendData:(NSData *)data {
    NSError *error;
    BOOL success = [[GCHelper sharedInstance].match sendDataToAllPlayers:data withDataMode:GKMatchSendDataUnreliable error:&error];
    if (!success) {
        NSLog(@"Error sending init packet");
        [self matchEnded];
    }
}

- (void)sendRandomNumber {
    
    messageSelectingHost message;
    message.message.messageType = kMessageTypeSendHost;
    message.hostNumber = ourRandom;
    NSData *data = [NSData dataWithBytes:&message length:sizeof(messageSelectingHost)];
    [self sendData:data];
}

-(void)sendSelectedOptions {
    messageSendTimeOptions timeMessage;
    messageSendAppleOptions appleMessage;
    timeMessage.message.messageType = kMessageTypeSendTimeOptions;
    appleMessage.message.messageType = kMessageTypeSendAppleOptions;
    timeMessage.time = selectedTime;
    appleMessage.apples = targetApples;
    
    NSData *time = [NSData dataWithBytes:&timeMessage length:sizeof(timeMessage)];
    NSData *apples = [NSData dataWithBytes:&appleMessage length:sizeof(appleMessage)];
   
    [self sendData:time];
    [self sendData:apples];
}

- (void)sendGameBegin {
    
    MessageGameBegin message;
    message.message.messageType = kMessageTypeGameBegin;
    NSData *data = [NSData dataWithBytes:&message length:sizeof(message)];
    [self sendData:data];
    
}

- (void)sendCurrentApples {
    messageSendCurrentApples message;
    message.message.messageType = kMessageTypeSendTotalApples;
    if(isPlayer1) {
        message.apples = player1Apples;
    } else {
        message.apples = player2Apples;
    }
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageGameOver)];
    [self sendData:data];
    
}

- (void)sendGameOver:(BOOL)player1Won {
    
    MessageGameOver message;
    message.message.messageType = kMessageTypeGameOver;
    message.player1Won = player1Won;
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageGameOver)];
    [self sendData:data];
    
}

- (void)tryStartGame {
    
    self.GameState = kGameStateActive;
    [self sendGameBegin];
    
}

#pragma mark GCHelperDelegate

- (void)matchStarted {
    NSLog(@"Match started");
    if (hostSelected) {
        [self setGameState:kGameStateSelectingOptions];
    } else {
        self.GameState = kGameStateSelectingHost;
    }
    [self sendRandomNumber];
    [self tryStartGame];
}


- (void)matchEnded {
    NSLog(@"Match ended");
    
    [[GCHelper sharedInstance].match disconnect];
    [GCHelper sharedInstance].match = nil;
}

- (void)match:(GKMatch *)match didReceiveData:(NSData *)data fromPlayer:(NSString *)playerID {
    
    // Store away other player ID for later
    if (otherPlayerID == nil) {
        otherPlayerID = playerID;
    }

    NSLog(@"Recieved data!");
    Message *message = (Message *) [data bytes];
    if (message->messageType == kMessageTypeSendHost) {
        
        messageSelectingHost * messageInit = (messageSelectingHost *) [data bytes];
        NSLog(@"Received random number: %ud, ours %ud", messageInit->hostNumber, ourRandom);
        bool tie = false;
        
        if (messageInit->hostNumber == ourRandom) {
            NSLog(@"TIE!");
            tie = true;
            ourRandom = arc4random();
            [self sendRandomNumber];
        } else if (ourRandom > messageInit->hostNumber) {
            NSLog(@"We are player 1");
            isPlayer1 = YES;
        } else {
            NSLog(@"We are player 2");
            isPlayer1 = NO;
        }
        
        if (!tie) {
            hostSelected = YES;
            if (kGameStateSelectingHost) {
                [self setGameState:kGameStateSelectingOptions];
            }
            [self tryStartGame];
        }
        
    } else if (message->messageType == kMessageTypeGameBegin) {
        
        [self setGameState:kGameStateActive];
        
    } else if (message->messageType == kMessageTypeGameOver) {
        
        MessageGameOver * messageGameOver = (MessageGameOver *) [data bytes];
        NSLog(@"Received game over with player 1 won: %d", messageGameOver->player1Won);
            
    } else if(message->messageType == kMessageTypeSendTimeOptions) {
        selectedTime = *(int*) [data bytes];
    } else if(message->messageType == kMessageTypeSendAppleOptions) {
        targetApples = *(int*) [data bytes];
    } else if(message->messageType == kMessageTypeSendTotalApples) {
        if(isPlayer1) {
            player1Apples = *(float*) [data bytes];
        } else {
            player2Apples = *(float*) [data bytes];
        }
    }
}

-(void)backToMenu {
    [self performSegueWithIdentifier:@"mutliplayerToMenu" sender:self];
}



@end
