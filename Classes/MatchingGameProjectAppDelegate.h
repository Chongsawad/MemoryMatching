//
//  MatchingGameProjectAppDelegate.h
//  MatchingGameProject
//
//  Created by InICe on 7/17/2553.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatchingGameProjectAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController *navController;
}

-(IBAction)GameStartMenuLoad:(id)sender;

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

