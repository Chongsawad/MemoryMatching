//
//  StartGameViewController.h
//  MatchingGameProject
//
//  Created by InICe on 7/18/2553.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StartGameViewController : UIViewController {
	IBOutlet UIButton *sport;
	IBOutlet UIButton *cartoon;
	IBOutlet UIButton *fruit;
	IBOutlet UIButton *settingView;
	IBOutlet UIButton *highScoreView;
	IBOutlet UIImageView *backgroundView;
	IBOutlet UIScrollView *scrollView;
	NSArray *listScore;
}
-(IBAction)highScoreViewLoad:(id)sender;
//-(IBAction)settingViewLoad:(id)sender;
-(IBAction)startLoadGame:(id)sender;

@end
