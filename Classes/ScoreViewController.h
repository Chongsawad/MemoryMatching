//
//  ScoreViewController.h
//  MatchingGameProject
//
//  Created by InICe on 7/22/2553.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ScoreViewController : UITableViewController {

	NSArray *scoreDataList;
}

@property(nonatomic,retain) NSArray *scoreDataList;

@end
