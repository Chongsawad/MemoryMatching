//
//  EndGame.m
//  MatchingGameProject
//
//  Created by InICe on 7/18/2553.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "EndGame.h"
#import "HighScoreViewController.h"

@implementation EndGame

@synthesize playerScore;
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
	textTitle.text = self.title;
	playerName.delegate = self;
	scoreView.text = [NSString stringWithFormat:@"%d",self.playerScore];
	[playerName becomeFirstResponder];
	self.navigationItem.hidesBackButton = YES;
	
	
	
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	[self goToMainVew:nil];
	return YES;
}

-(IBAction)goToMainVew:(id)sender{
	
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *pathToList = [bundle pathForResource:@"topScore" ofType:@"plist"];
	listData =  [NSMutableArray arrayWithContentsOfFile:pathToList];
	[listData addObject:[NSString stringWithFormat:@"%d,%@",self.playerScore,playerName.text]];

	
	NSUInteger i,count = [listData count];
	NSMutableArray *sepArray = [[NSMutableArray alloc] init];
	
	for (i = 0; i < count; i++) {
		NSArray *obj = [[listData objectAtIndex:i] componentsSeparatedByString:@","];
		[sepArray addObject:obj];
	}
	
	for (int i = 0; i < count; i++){
		for (int j = 1; j < count; j++) {
			NSInteger tmpA = [[[sepArray objectAtIndex:j-1] objectAtIndex:0] intValue];
			NSInteger tmpB = [[[sepArray objectAtIndex:j] objectAtIndex:0] intValue];
			if(tmpA < tmpB){
				[sepArray exchangeObjectAtIndex:j-1 withObjectAtIndex:j];
				NSLog(@"%d < %d, at i = %i , j = %i", tmpA,tmpB,i,j);
				
			}
		}
	}	
	
	for (int i=0; i< count; i++) {
		[sepArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%@,%@",[[sepArray objectAtIndex:i] objectAtIndex:0],[[sepArray objectAtIndex:i] objectAtIndex:1]]];
	}

	listData = sepArray;
	NSLog(@"%@",listData);
	[listData writeToFile:pathToList atomically:YES];
	
	HighScoreViewController *scoreViewController = [[HighScoreViewController alloc] init];
	scoreViewController.scoreDataList = listData;	
	[self.navigationController pushViewController:scoreViewController animated:YES];
	[scoreViewController release];
}

- (void)dealloc {
    [super dealloc];
}


@end
