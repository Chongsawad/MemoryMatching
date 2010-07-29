//
//  settingViewController.h
//  MatchingGameProject
//
//  Created by InICe on 7/26/2553.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface settingViewController : UIViewController {
	IBOutlet UIButton *done;
	IBOutlet UIButton *gameEasy;
	IBOutlet UIButton *gameMedium;
	IBOutlet UIButton *gameHard;
}

-(IBAction)doneButton:(id)sender;
-(IBAction)gameLevelCustom:(id)sender;

@end
