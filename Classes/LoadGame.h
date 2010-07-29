//
//  LoadGame.h
//  MatchingGameProject
//
//  Created by InICe on 7/18/2553.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadGame : UIViewController <UIActionSheetDelegate> {
	IBOutlet UIButton *endGame;
	IBOutlet UILabel *scoreLabel;
	IBOutlet UILabel *timerLabel;
	IBOutlet UIImageView *background;
	IBOutlet UIImageView *powerView;
	IBOutlet UIProgressView *powerBar;
	IBOutlet UIButton *newGame;
	
	UIImageView *backDrop;
	UIImage *cardImage;
	
	NSMutableArray *items;
	
	NSMutableArray *buttonId;
	NSTimer *timer;
	int mil,sec,min,delayCount,matchCount;
	float speedTimeAdjust;
	BOOL firstTouch,secondTouch,touchOK,matchFlag,initButtonFlag;
	id firstObject,secondObject;
	int score,matchHit,waitForEndGame,initButtonDelay,initButtonCount,initIndexX,initIndexY,initAnimatedFromPosition;
	int gameLevel,row,column;
	float buttonWidth,buttonHeight,buttonMargin;

}

@property int score;
@property int matchHit;
@property int gameLevel;

@property(nonatomic, assign) int initAnimatedFromPosition;

@property BOOL firstTouch;
@property BOOL secondTouch;
@property BOOL touchOK;
@property BOOL matchFlag;

@property(nonatomic, retain) NSMutableArray* items;
@property(nonatomic, retain) id firstObject;
@property(nonatomic, retain) id secondObject;

@property(nonatomic, assign) UIImage *cardImage;

-(IBAction)addScore:(id)sender;
-(IBAction)endGame:(id)sender;
-(IBAction)genButton;
-(IBAction)newGame;

-(void)dukDig;
-(void)initGame;
-(void)runArray;
-(void)refreshButton;
-(void)clearTurn;
-(void)timeTicker;
-(void)fadeOutButton;
-(void)gameLevelSettings;

@end
