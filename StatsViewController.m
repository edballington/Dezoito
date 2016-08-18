//
//  StatsViewController.m
//  Dezoito
//
//  Created by Ed Ballington on 4/8/15.
//  Copyright (c) 2015 Ed Ballington. All rights reserved.
//

#import "StatsViewController.h"

@interface StatsViewController ()

@property (nonatomic, strong) Statistics *currentStats;

@end

@implementation StatsViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* Load stats from saved file if it exists */
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataFile = [documentsDirectory stringByAppendingPathComponent:@"statsData"];
    
    if ( [[NSFileManager defaultManager]fileExistsAtPath:dataFile] ) {
        
        self.currentStats = [NSKeyedUnarchiver unarchiveObjectWithFile:dataFile];
        
        if (self.currentStats == nil) {   //Stats file exists but hasn't been setup yet
            self.currentStats = [[Statistics alloc]init];
        }
        
    } else {
        
        self.currentStats = [[Statistics alloc]init];
        
    }
    
    /*Round the corners of the Reset Stats button */
    [self.resetButton.layer setCornerRadius:15.0f];
    [self.resetButton.layer setMasksToBounds:YES];
    
    /*Start it up with the "All" segment selected */
    [self selectLevel:self.segment];

}

#pragma mark - Actions

-(IBAction)resetStatsButton:(id)sender {
    
    /* First alert the user that this will wipe the stats and confirm that this is what is wanted */
    [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"This will delete the current statistics.\nAre you sure?"
                               delegate:self
                      cancelButtonTitle:@"Cancel"
                      otherButtonTitles:@"OK", nil] show];
    
}

-(void) resetStatistics {

    /* Zero out all stats */
    [self.currentStats reset];
    
    /* Save stats to file */
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataFile = [documentsDirectory stringByAppendingPathComponent:@"statsData"];
    
    BOOL success = [NSKeyedArchiver archiveRootObject:self.currentStats toFile:dataFile ];   //write zeroed out current stats to archive file
    
    if (!success) {
        NSLog(@"Problem with archiving stats data");
    }
    
    /*Refresh the display*/
    [self selectLevel:self.segment];
    
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    /* This method called when the user clicks a button on the alertview that is displayed to warn the user that stats will be deleted */
    
    if (buttonIndex == 1) {     //Ok button
        
        [self resetStatistics];
        
    } else {                    //Cancel button
        
        nil;
    }

    
}

-(IBAction)selectLevel:(id)sender {
    
    NSInteger segmentIndex = [self.segment selectedSegmentIndex];
    
    switch (segmentIndex) {
            
        case 0:   //Easy
            self.puzzlesSolved.text = [NSString stringWithFormat:@"%li", (long)self.currentStats.level1PuzzlesSolved];
            self.averageTime.text = [NSString stringWithFormat: @"%li:%02li", (long)labs([self.currentStats averageForLevel:1] / 60), (long)fmod([self.currentStats averageForLevel:1], 60)];
            self.recordTime.text = [NSString stringWithFormat:@"%li:%02li", (long)labs(self.currentStats.level1RecordTime / 60), (long)fmod(self.currentStats.level1RecordTime, 60)];
            break;
        case 1:   //Medium
            self.puzzlesSolved.text = [NSString stringWithFormat:@"%li", (long)self.currentStats.level2PuzzlesSolved];
            self.averageTime.text = [NSString stringWithFormat: @"%li:%02li", (long)labs([self.currentStats averageForLevel:2] / 60), (long)fmod([self.currentStats averageForLevel:2], 60)];
            self.recordTime.text = [NSString stringWithFormat:@"%li:%02li", (long)labs(self.currentStats.level2RecordTime / 60), (long)fmod(self.currentStats.level2RecordTime, 60)];
            break;
        case 2:   //Hard
            self.puzzlesSolved.text = [NSString stringWithFormat:@"%li", (long)self.currentStats.level3PuzzlesSolved];
            self.averageTime.text = [NSString stringWithFormat: @"%li:%02li", (long)labs([self.currentStats averageForLevel:3] / 60), (long)fmod([self.currentStats averageForLevel:3], 60)];
            self.recordTime.text = [NSString stringWithFormat:@"%li:%02li", (long)labs(self.currentStats.level3RecordTime / 60), (long)fmod(self.currentStats.level3RecordTime, 60)];
            break;
        case 3:   //Expert
            self.puzzlesSolved.text = [NSString stringWithFormat:@"%li", (long)self.currentStats.level4PuzzlesSolved];
            self.averageTime.text = [NSString stringWithFormat: @"%li:%02li", (long)labs([self.currentStats averageForLevel:4] / 60), (long)fmod([self.currentStats averageForLevel:4], 60)];
            self.recordTime.text = [NSString stringWithFormat:@"%li:%02li", (long)labs(self.currentStats.level4RecordTime / 60), (long)fmod(self.currentStats.level4RecordTime, 60)];
            break;
        case 4:   //Total
            self.puzzlesSolved.text = [NSString stringWithFormat:@"%li", (long)[self.currentStats allPuzzlesSolved]];
            self.averageTime.text = [NSString stringWithFormat: @"%li:%02li", (long)labs([self.currentStats compositeAverage] / 60), (long)fmod([self.currentStats compositeAverage], 60)];
            self.recordTime.text = [NSString stringWithFormat:@"%li:%02li", (long)labs([self.currentStats allRecordTime] / 60), (long)fmod([self.currentStats allRecordTime], 60)];
            break;
        default:
            break;
            
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
