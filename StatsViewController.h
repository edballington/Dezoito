//
//  StatsViewController.h
//  Dezoito
//
//  Created by Ed Ballington on 4/8/15.
//  Copyright (c) 2015 Ed Ballington. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Statistics.h"

@interface StatsViewController : UIViewController <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *puzzlesSolved;
@property (weak, nonatomic) IBOutlet UILabel *averageTime;
@property (weak, nonatomic) IBOutlet UILabel *recordTime;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;

-(IBAction)resetStatsButton:(id)sender;
-(IBAction)selectLevel:(id)sender;

@end
