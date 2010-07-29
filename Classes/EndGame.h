//
//  EndGame.h
//  MatchingGameProject
//
//  Created by InICe on 7/18/2553.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EndGame : UIViewController <UITextFieldDelegate>{
	IBOutlet UIButton *goToMain;
	IBOutlet UITextField *playerName;
	IBOutlet UILabel *scoreView;
	IBOutlet UILabel *textTitle;
	NSInteger playerScore;
	NSMutableArray *listData;
}

-(IBAction)goToMainVew:(id)sender;

-(BOOL)textFieldShouldReturn:(UITextField *)textField;

@property(nonatomic,assign) NSInteger playerScore;

@end
