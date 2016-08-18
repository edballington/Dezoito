//
//  ViewController.h
//  Dezoito
//
//  Created by Ed Ballington on 5/13/14.
//  Copyright (c) 2014 Ed Ballington. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Puzzle.h"
#import "PuzzleViewController.h"

@interface ViewController : UIViewController <UIActionSheetDelegate, UIAlertViewDelegate>
- (IBAction)newGame:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *resumeGameButton;
@property (weak, nonatomic) IBOutlet UIButton *startGameButton;
@property (weak, nonatomic) IBOutlet UIImageView *dezoitoImageView;

@end
