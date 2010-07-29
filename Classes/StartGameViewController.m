//
//  StartGameViewController.m
//  MatchingGameProject
//
//  Created by InICe on 7/18/2553.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "StartGameViewController.h"
#import "LoadGame.h"
#import "settingViewController.h"
#import "HighScoreViewController.h"


@implementation StartGameViewController

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
	scrollView.decelerationRate = 0.1;
	scrollView.frame = CGRectMake(0, 40, 610, 210);
	[scrollView setContentSize:CGSizeMake(900, 200)];
	[scrollView setContentOffset:CGPointMake(120,0)];
	backgroundView.frame = CGRectMake(0, 0, 320, 480);
	self.navigationController.navigationBarHidden = YES;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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

-(IBAction)settingViewLoad:(id)sender{
	settingViewController *customeGame = [[settingViewController alloc] init];
	[self.navigationController pushViewController:customeGame animated:YES];
	[customeGame release];
}

-(IBAction)highScoreViewLoad:(id)sender{
	//ScoreViewController *scoreView = [[ScoreViewController alloc] init];
	HighScoreViewController *scoreView = [[HighScoreViewController alloc] init];
	
	NSBundle *bundle = [NSBundle mainBundle];
	
	NSString *pathToList = [bundle pathForResource:@"topScore" ofType:@"plist"];
	
	listScore =  [NSArray arrayWithContentsOfFile:pathToList];
	
	scoreView.scoreDataList = [listScore sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
	
	[self.navigationController pushViewController:scoreView animated:YES];
	
	[scoreView release];
}


-(IBAction)startLoadGame:(id)sender{
	LoadGame *lgame = [[LoadGame alloc] init];

	if(sender == fruit) {
		lgame.items = [NSMutableArray arrayWithObjects: @"1_mango", @"1_mango",@"2_pear", @"2_pear"
					   ,@"3_banana", @"3_banana",@"4_strawberry", @"4_strawberry"
					   ,@"5_mangosteen", @"5_mangosteen",@"6_kiwi", @"6_kiwi"
					   ,@"7_orange", @"7_orange",@"8_coconut", @"8_coconut",nil];
	
		lgame.cardImage = [UIImage imageNamed:@"cardFruit"];
	}
	else if(sender == sport){
		
		lgame.items = [NSMutableArray arrayWithObjects: @"1_ball", @"1_equipment",@"2_ball", @"2_equipment"
					   ,@"3_ball", @"3_equipment",@"4_ball", @"4_equipment"
					   ,@"5_ball", @"5_equipment",@"6_ball", @"6_equipment"
					   ,@"7_ball", @"7_equipment",@"8_ball", @"8_equipment",nil];
		lgame.cardImage = [UIImage imageNamed:@"cardSport"];
	}
	else if(sender == cartoon){
		lgame.items = [NSMutableArray arrayWithObjects: @"1_cat", @"1_cat",@"2_fish",@"2_fish"
					   ,@"3_dog",@"3_dog",@"4_elephant",@"4_elephant"
					   ,@"5_bird",@"5_bird",@"6_frog",@"6_frog"
					   ,@"7_panda",@"7_panda",@"8_fox",@"8_fox",nil];
		
		lgame.cardImage = [UIImage imageNamed:@"cardCartoon"];
		
		/* lgame.items = [NSMutableArray arrayWithObjects: @"1_ball", @"1_ball",@"1_ball", @"1_ball"
		 ,@"1_ball", @"1_ball",@"1_ball", @"1_ball"
		 ,@"1_ball", @"1_ball",@"1_ball", @"1_ball"
		 ,@"1_ball", @"1_ball",@"1_ball", @"1_ball",nil];*/
	}
	[self.navigationController pushViewController:lgame animated:YES];
	//[lgame release];	
}

- (void)dealloc {
	
    [super dealloc];
}


@end
