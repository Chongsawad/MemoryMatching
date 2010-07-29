//
//  HighScoreViewController.h
//  MatchingGameProject
//
//  Created by InICe on 7/27/2553.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HighScoreViewController : UIViewController {
	NSMutableArray *buttonSet;
	NSArray *scoreDataList;
	NSTimer *timerScore;
	NSUInteger index, countArray;
	IBOutlet UIButton *closeButton;
	IBOutlet UIImageView *backdrop;
	IBOutlet UIImageView *background;
}

@property(nonatomic, retain) NSArray *scoreDataList;


-(void)closeView:(id)sender;
-(void)timeFadeDuration;
-(void)sortHighScore;
-(void)genScoreViewLabel:(id)sender;

@end
