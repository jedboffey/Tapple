//
//  rootMultiplayerViewController.h
//  Tapple
//
//  Created by Jed on 05/10/2013.
//  Copyright (c) 2013 Jed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import "GCHelper.h"

typedef enum {
    kGameStateWaitingForMatch = 0,
    kGameStateSelectingHost,
    kGameStateSelectingOptions,
    kGameStateActive,
    kGameStateDone
} GameState;

typedef enum {
    kEndReasonWin,
    kEndReasonLose,
    kEndReasonDisconnect
} EndReason;

typedef enum {
    kMessageTypeSendHost,
    kMessageTypeSendTimeOptions,
    kMessageTypeSendAppleOptions,
    kMessageTypeSendTotalApples,
    kMessageTypeGameBegin,
    kMessageTypeGameOver
} MessageType;

typedef struct {
    MessageType messageType;
} Message;

typedef struct {
    Message message;
    uint32_t hostNumber;
} messageSelectingHost;

typedef struct {
    Message message;
    int time;
} messageSendTimeOptions;

typedef struct {
    Message message;
    int apples;
} messageSendAppleOptions;

typedef struct {
    Message message;
    int apples;
} messageSendCurrentApples;

typedef struct {
    Message message;
} MessageGameBegin;

typedef struct {
    Message message;
    BOOL player1Won;
} MessageGameOver;

@interface rootMultiplayerViewController : UIViewController <GCHelperDelegate> {
    float player1Apples;
    float player2Apples;
    int ourRandom;
    BOOL optionsSelected;
    BOOL isPlayer1;
    BOOL isPlayer2;
    BOOL hostSelected;
    NSString *otherPlayerID;
    int selectedTime;
    int targetApples;
}

@property enum GameState;
@property(nonatomic) int selectedTime;
@property(nonatomic) int targetApples;

@end
