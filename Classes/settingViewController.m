//
//  settingViewController.m
//  MatchingGameProject
//
//  Created by InICe on 7/26/2553.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "settingViewController.h"
#import "LoadGame.h"


@implementation settingViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationController.navigationBarHidden = YES;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(IBAction)gameLevelCustom:(id)sender{
	LoadGame *customeGame = [[LoadGame alloc] init];
	if(sender == gameEasy){
		customeGame.gameLevel = 12;
	} else if (sender == gameMedium) {
		customeGame.gameLevel = 16;
	} else if (sender == gameHard) {
		customeGame.gameLevel = 20;
	}
}

-(IBAction)doneButton:(id)sender{
	self.navigationController.navigationBarHidden = YES;
	[self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
