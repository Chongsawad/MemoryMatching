//
//  HighScoreViewController.m
//  MatchingGameProject
//
//  Created by InICe on 7/27/2553.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HighScoreViewController.h"
#import <QuartzCore/QuartzCore.h>



@implementation HighScoreViewController
@synthesize scoreDataList;
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
	background.frame = CGRectMake(0, 0, 320, 480);
	
	[self sortHighScore];
	[self genScoreViewLabel:nil];
	index = 0, countArray = [buttonSet count];
	timerScore = [NSTimer scheduledTimerWithTimeInterval:(0.4) target:self selector:@selector(timeFadeDuration) userInfo:nil repeats:YES];
	
	CALayer *rad = backdrop.layer;
	[rad setMasksToBounds:YES];
	[rad setCornerRadius:10.0];
	[rad setBorderWidth:3.0];
	[rad setBorderColor:[[UIColor blackColor] CGColor]];
}

- (void)closeView:(id)sender{
	[self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)timeFadeDuration{
	if(index < countArray) {
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationBeginsFromCurrentState:YES];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
		[UIView setAnimationDuration:1.5];
		
		NSArray * obj = [buttonSet objectAtIndex:index];

		[[obj objectAtIndex:0] setFont:[UIFont systemFontOfSize:17.0]];		
		[[obj objectAtIndex:1] setFont:[UIFont systemFontOfSize:17.0]];
		[[obj objectAtIndex:0] setAlpha:1.0];
		[[obj objectAtIndex:1] setAlpha:1.0];
		[UIView commitAnimations];	
		index++;
			
	}
	else {
		[timerScore invalidate];
	}
	

	//NSLog(@"index = %i, count = %i",index,count);

}

- (void)sortHighScore{
	NSUInteger countData = [self.scoreDataList count];
	NSMutableArray *sepArray = [[NSMutableArray alloc] init];
	NSLog(@"scoreDataList = %@ , countData = %i",self.scoreDataList,countData);	
	
	for (int a = 0; a < countData; a++) {
		NSObject *obj = [[self.scoreDataList objectAtIndex:a] componentsSeparatedByString:@","];
		[sepArray addObject:obj];
	}
	
	
	
	for (int i = 0; i < countData; i++){
		for (int j = 0; j < countData - 1; j++) {
			NSInteger tmpA = [[[sepArray objectAtIndex:j] objectAtIndex:0] intValue];
			NSInteger tmpB = [[[sepArray objectAtIndex:j+1] objectAtIndex:0] intValue];
			
			if(tmpA > tmpB){
				[sepArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
				NSLog(@"%d < %d, at i = %i , j = %i", tmpA,tmpB,i,j);	
			}
		}
	}	
	
	for (int i=0; i< countData; i++) {
		[sepArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%@,%@",[[sepArray objectAtIndex:i] objectAtIndex:0],[[sepArray objectAtIndex:i] objectAtIndex:1]]];
	}
	
	for (int i=0; i< countData/2; i++) {
		[sepArray exchangeObjectAtIndex:i withObjectAtIndex:countData-i-1];
	}
	
	NSLog(@"seperate Array ::: %@",sepArray);
	
	self.scoreDataList = sepArray;
	[sepArray release];
	
}


- (void)genScoreViewLabel:(id)sender{
	NSUInteger i, c = [scoreDataList count];
	buttonSet = [[NSMutableArray alloc] init];
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSLog(@"Generate Label , scoreDataList = %@",self.scoreDataList);
	for (i = 0; i < c; i++) {
		if(i == 10){
			NSLog(@"Bounded!");
			return;
		}
		UILabel *scoreName = [[UILabel alloc] init];
		NSArray *tmpSeperateStringToArray = [[NSString stringWithFormat:@"%@",[scoreDataList objectAtIndex:i]] componentsSeparatedByString:@","];

		scoreName.text = [NSString stringWithFormat:@"%i. %@",i+1,[tmpSeperateStringToArray objectAtIndex:1]];
		
		CGRect frame = CGRectMake(60, 80, 280, 30);
		frame.origin.y += i*35;
		scoreName.frame = frame;
		scoreName.textAlignment = UITextAlignmentLeft;
		scoreName.textColor = [UIColor blackColor];
		scoreName.font = [UIFont systemFontOfSize:36.0];
		scoreName.backgroundColor = [UIColor clearColor];
		scoreName.alpha = 0.0;
		
		UILabel *score = [[UILabel alloc] init];
		frame.size.width = 200;
		score.frame = frame;
		score.alpha = 0.0;
		score.font = [UIFont systemFontOfSize:36.0];
		score.textAlignment = UITextAlignmentRight;
		score.backgroundColor = [UIColor clearColor];
		scoreName.textColor = [UIColor blackColor];
		score.text = [NSString stringWithFormat:@"%@",[tmpSeperateStringToArray objectAtIndex:0]];
		

		[buttonSet addObject:[NSArray arrayWithObjects:scoreName, score,nil]];

		[self.view addSubview:score];
		[self.view addSubview:scoreName];

	}
	
	[pool release];
	
	
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


- (void)dealloc {
	[buttonSet release];
    [super dealloc];
}


@end
