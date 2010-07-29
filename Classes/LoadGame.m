//
//  LoadGame.m
//  MatchingGameProject
//
//  Created by InICe on 7/18/2553.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LoadGame.h"
#import "EndGame.h"
#import <QuartzCore/QuartzCore.h>

@implementation LoadGame

@synthesize firstTouch,secondTouch,firstObject,secondObject;
@synthesize touchOK,matchFlag;
@synthesize matchHit;
@synthesize score;
@synthesize items;
@synthesize initAnimatedFromPosition;
@synthesize gameLevel;
@synthesize cardImage;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {

    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.navigationController.navigationBarHidden = YES;
    [super viewDidLoad];
	[self.view addSubview:background];
	[self.view sendSubviewToBack:background];	
	[self initGame];
	[self dukDig];
	[self runArray];
	[self genButton];
	
}

-(void)dukDig{

	powerView.animationImages = [NSArray arrayWithObjects:    
										 [UIImage imageNamed:@"tiger-1.png"],
										 [UIImage imageNamed:@"tiger-2.png"], nil];
	powerView.animationDuration = 0.5f;
	powerView.animationRepeatCount = 0;
	[powerView startAnimating];
	
}



-(void)initGame{
	mil,sec,min = 0;
	initButtonFlag = NO;
	speedTimeAdjust = 0.001;
	delayCount = 0;
	waitForEndGame = -1;
	self.matchHit = 0;
	self.firstTouch = NO;
	self.secondTouch = NO;
	self.touchOK = YES;
	self.matchFlag = NO;
	
	if(self.cardImage == NULL){
		self.cardImage = [UIImage imageNamed:@"cardCartoon.png" ];

	}
	
	if(self.initAnimatedFromPosition == 0){
		initAnimatedFromPosition = arc4random()%4+1;
	}
	
	
	[self.view bringSubviewToFront:newGame];
	
	timer = [NSTimer scheduledTimerWithTimeInterval:(0.1) target:self selector:@selector(timeTicker) userInfo:nil repeats:YES];
	
	matchCount = [items count]/2;
}

-(void)runArray{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSInteger count = [items count];
	for (int i=0; i< count; i++) {
		int num = arc4random()%count;
		[items exchangeObjectAtIndex:i withObjectAtIndex:num];
	}	
	[pool release];
}

-(void)gameLevelSettings{
	self.gameLevel = 16;
	
	switch (self.gameLevel) {
		case 12:
			row = 4;
			column = 3;
			buttonWidth = 100.0;
			buttonHeight = 100.0;
			buttonMargin = 5;
			break;
			
		case 16:
			row = 4;
			column = 4;
			buttonWidth = 70.0;
			buttonHeight = 93.0;
			buttonMargin = 7;
			
			break;
		case 20:
			row = 5;
			column = 4;
			buttonWidth = 77.5;
			buttonHeight = 80.0;
			buttonMargin = 2;
			
			break;
			
		default:
			row = 4;
			column = 4;
			buttonWidth = 75.0;
			buttonHeight = 100.0;
			buttonMargin = 5;
			break;
	}
}

-(void)genButton{
	[self gameLevelSettings];
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	int count=0;
	
	CGRect frame;
	
	buttonId = [[NSMutableArray alloc] init];
	
	CGRect LEFT_TOP = CGRectMake(-100.0,-200.0, buttonWidth, buttonHeight);
	CGRect LEFT_BOTTOM = CGRectMake(-100.0,600.0, buttonWidth, buttonHeight);
	CGRect RIGHT_TOP = CGRectMake(400.0,-200.0, buttonWidth, buttonHeight);
	CGRect RIGHT_BOTTOM = CGRectMake(400.0,600.0, buttonWidth, buttonHeight);

	for (int i=0; i < row; i++) {
		for (int j=0; j < column; j++) {
			
			switch (self.initAnimatedFromPosition) {
				case 0:
					//NO ANIMATED
					frame = CGRectMake(buttonMargin+(buttonWidth+buttonMargin)*j, buttonMargin+(buttonHeight)*i, buttonWidth, buttonHeight);
					break;
				case 1:
					frame = LEFT_TOP;
					break;
				case 2:
					frame = LEFT_BOTTOM;
					break;
				case 3:
					frame = RIGHT_TOP;
					break;
				case 4:
					frame = RIGHT_BOTTOM;
					break;
				default:
					//NO ANIMATED
					frame = CGRectMake(buttonMargin+(buttonWidth+buttonMargin)*j, buttonMargin+(buttonHeight)*i, buttonWidth, buttonHeight);
					break;
			}

			UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
			
			button.frame = frame;
			[button setTitle:[NSString stringWithFormat:@"%@",[items objectAtIndex:count]] forState:UIControlStateNormal];
			[button setImage:cardImage forState:UIControlStateNormal];
			button.titleLabel.font = [UIFont systemFontOfSize:1];
			button.contentMode = UIViewContentModeScaleAspectFit;
			[button addTarget:self action:@selector(eventTouchObserved:) forControlEvents:UIControlEventTouchUpInside];

			[buttonId addObject:button];
			
			[self.view addSubview:button];
			
			count++;
		}
	}
	[pool release];
	initButtonFlag = YES;
}

// **************************************************************** //

-(void)timeTicker{
	if (touchOK == NO) {
		if(delayCount == 8){
			[self refreshButton];
			if(matchFlag == NO) delayCount=0;
		}
		if(delayCount == 15){
			[self fadeOutButton];
			touchOK = YES;
			delayCount = 0;
		}
		delayCount++;
	}
	
	if(waitForEndGame >= 0){
		if (waitForEndGame == 15) {
			[self endGame:nil];
		}
		waitForEndGame++;
	}
	
	if(initButtonFlag == YES){
		if(initButtonDelay == 1){
			if(initButtonCount < gameLevel){
				if(initIndexX == column){initIndexY += 1; initIndexX=0;}
				
				UIButton *initButton = [buttonId objectAtIndex:initButtonCount];
				CGRect buttonFrame = [initButton frame];
				
				[UIView beginAnimations:nil context:NULL];
				[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
				[UIView setAnimationBeginsFromCurrentState:YES];
				[UIView setAnimationDuration:0.3];
				
				buttonFrame.origin.x = (buttonMargin*(initIndexX+1))+2+(buttonWidth*initIndexX);
				buttonFrame.origin.y = buttonMargin+(buttonHeight+4)*initIndexY+4;
				
				[initButton setFrame:buttonFrame];
				
				[UIView commitAnimations];
				
				initIndexX++;
				initButtonCount++;
				initButtonDelay=0;
				[initButton release];
			}
			else {
				initButtonFlag = NO;
			}

		}
		initButtonDelay++;
	}
	
	if(powerBar.progress > 0) powerBar.progress -= speedTimeAdjust;
	if (powerBar.progress == 0) {
		[self endGame:nil];
	}
	if(sec==59){ min+=1; sec=0;} else{ if(mil==10){ sec+=1; mil=0; } else{ mil+=1;}}
	timerLabel.text = [NSString stringWithFormat:@"%02d:%02d",min,sec];
	
}

// **************************************************************** //

-(IBAction)eventTouchObserved:(id)sender{
	
	if (self.touchOK == YES) {
		if (firstTouch == YES) {
			if (firstObject != sender) {
				self.matchHit +=1;
				self.secondTouch = YES;
				self.secondObject = [buttonId objectAtIndex:[buttonId indexOfObjectIdenticalTo:sender]];
				
				[UIView beginAnimations:nil context:NULL];
				[UIView setAnimationDuration:0.3];
				[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:secondObject cache:NO];
				[secondObject setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[secondObject currentTitle]]] forState:UIControlStateNormal];
				[UIView commitAnimations];
				
				NSRange range =  NSMakeRange(0, 1);
				
				NSLog(@"firstString = %@ : secondString = %@",[[firstObject currentTitle] substringWithRange:range],[[secondObject currentTitle] substringWithRange:range]);

				if([[[firstObject currentTitle] substringWithRange:range] isEqualToString: [[secondObject currentTitle] substringWithRange:range]])
				{
					matchCount-=1;
					NSLog(@"Match. ^_^");
					self.matchFlag = YES;
					[self addScore:sender];
					
				} else {
					if(self.score >=1) self.score -=1; 
					scoreLabel.text = [NSString stringWithFormat:@"%i",self.score];
				}
				self.touchOK = NO;
				
			}
		} else {
			
			self.firstTouch = YES;
			self.firstObject = [buttonId objectAtIndex:[buttonId indexOfObjectIdenticalTo:sender]];
			
			/*CGRect fistObjectFrame = [self.firstObject frame];
			fistObjectFrame.size.width = buttonWidth;
			fistObjectFrame.size.height = buttonHeight;
			[self.firstObject setFrame:fistObjectFrame];*/
			
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:0.3];
			[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:firstObject cache:NO];
			[UIView commitAnimations];
			[firstObject setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[firstObject currentTitle]]] forState:UIControlStateNormal];


		}
		
	}
}

-(void)refreshButton{

	if(self.matchFlag == YES){	
		
		backDrop = [[UIImageView alloc] init];
		backDrop.backgroundColor = [UIColor blackColor];
		backDrop.frame = CGRectMake(0, 0, 320, 480);
		backDrop.alpha = 0.0;
		[self.view addSubview:backDrop];
		[self.view bringSubviewToFront:backDrop];
		[self.view bringSubviewToFront:firstObject];
		[self.view bringSubviewToFront:secondObject];	
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationBeginsFromCurrentState:YES];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
		[UIView setAnimationDuration:0.4];
		
		[backDrop setAlpha:0.4];
		
		CGRect cardFrame1 = [firstObject frame];
		CGRect cardFrame2  = [secondObject frame]; 
		
		cardFrame1.origin.x = cardFrame1.origin.x < cardFrame2.origin.x ? 60 : 200; 
		cardFrame1.origin.y = 180;
		
		[firstObject setFrame:cardFrame1];
		
		
		cardFrame2.origin.x = cardFrame1.origin.x == 200 ? 60 : 200; 
		cardFrame2.origin.y = 180;
		[secondObject setFrame:cardFrame2];
		
		[UIView commitAnimations];
	}
	else {

		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.25];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:firstObject cache:NO];
		[UIView commitAnimations];
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.25];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:secondObject cache:NO];
		[UIView commitAnimations];
	
		[firstObject setImage:cardImage forState:UIControlStateNormal];
		[secondObject setImage:cardImage forState:UIControlStateNormal];
		
		[self clearTurn];
		
	}		
	
}

-(void)fadeOutButton{
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:0.4];
	
	[backDrop setAlpha:0.0];
	
	CGRect oldFrame = [firstObject frame];
	oldFrame.origin.y += 500;
	[firstObject setFrame:oldFrame];
	
	oldFrame = [secondObject frame];
	oldFrame.origin.y += 500;
	[secondObject setFrame:oldFrame];
	
	[UIView commitAnimations];	
	
	[self clearTurn];
}

-(void)clearTurn{
	self.touchOK = YES;
	self.matchFlag = NO;
	self.firstTouch = NO;
	self.secondTouch = NO;
	firstObject=nil;
	secondObject=nil;

}



-(IBAction)addScore:(id)sender{
	self.score += 5;
	powerBar.progress += 0.05;
	scoreLabel.text = [NSString stringWithFormat:@"%i",self.score];
	if (score >= 40 || matchCount == 0) {
		waitForEndGame=0;
	}
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
    
	
}

-(IBAction)newGame{
	[timer invalidate];
	
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Do you want to stop the game?" delegate:self cancelButtonTitle:@"Resume" destructiveButtonTitle:@"New game" otherButtonTitles:nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	
	[actionSheet showInView:self.view]; 
	
	[actionSheet release];
	
}

- (void)actionSheet:(UIActionSheet *)action didDismissWithButtonIndex:(NSInteger)buttonIndex; {
	
    switch (buttonIndex) {
        case 0:
			[self.navigationController popToRootViewControllerAnimated:YES];
            break;
        case 1:
            timer = [NSTimer scheduledTimerWithTimeInterval:(0.1) target:self selector:@selector(timeTicker) userInfo:nil repeats:YES];
            break;
        default:
            break;
    }
	
}

-(IBAction)endGame:(id)sender{
	[timer invalidate];
	
	EndGame* egame = [[EndGame alloc] init];
	
	egame.title = matchCount == 0 ? @"Congratulation! You Win." : @"You lose";
	
	egame.playerScore = self.score;

	[self.navigationController pushViewController:egame animated:YES];
	
	[egame release];
	
}

- (void)dealloc {
	[timer release];
    [super dealloc];
}


@end
