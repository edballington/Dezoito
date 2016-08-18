//
//  PuzzleViewController.h
//  Dezoito
//
//  Created by Ed Ballington on 8/22/14.
//  Copyright (c) 2014 Ed Ballington. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Puzzle.h"
#import "SettingsConstants.h"
#import "Statistics.h"


@interface PuzzleViewController : UIViewController <UIAlertViewDelegate>

@property (nonatomic, strong) Puzzle *currentPuzzle;

@property (nonatomic) NSInteger beginSeconds; //Start seconds for puzzle timer
@property (weak, nonatomic) IBOutlet UILabel *stopWatchTimer;





@end
