//
//  PuzzleViewController.m
//  Dezoito
//
//  Created by Ed Ballington on 8/22/14.
//  Copyright (c) 2014 Ed Ballington. All rights reserved.
//

#import "PuzzleViewController.h"
#import "PuzzleView.h"
#import "Diamond.h"
#import "Square.h"


@interface PuzzleViewController ()

@property (weak, nonatomic) IBOutlet PuzzleView *puzzleView;
@property (nonatomic) BOOL useStopWatch;
@property (nonatomic) BOOL useSolutionGuide;
@property (nonatomic) BOOL enableBackgroundMusic;
@property (nonatomic) BOOL enableSoundEffects;
@property (nonatomic, strong) AVAudioPlayer *backgroundMusicPlayer;
@property (nonatomic, strong) AVAudioPlayer *buttonClickPlayer;
@property (nonatomic, strong) AVAudioPlayer *sectionSolvedPlayer;
@property (nonatomic, strong) AVAudioPlayer *puzzleSolvedPlayer;
@property (nonatomic, strong) Statistics *currentStats;

@end


@implementation PuzzleViewController

# pragma mark - local variables

/* Cell (index) to Diamond (value) mapping array */
int cellToDiamond[92]= {1,1,0,0,2,2,3,3,1,1,4,4,2,2,5,5,6,6,3,3,7,7,4,4,8,8,5,5,9,9,10,6,6,11,11,7,7,12,12,8,8,13,13,9,9,10,10,14,14,11,11,15,15,12,12,16,16,13,13,17,17,10,14,14,18,18,15,15,19,19,16,16,20,20,17,17,18,18,21,21,19,19,22,22,20,20,21,21,0,0,22,22};

/* Cell (index) to square (value) mapping arrays - 2 arrays neeeded because cells can potentially be in 2 overlapping squares - values of 99 indicate cell is only part of one square or not part of a square (edge cells) */
int cellToSquareA[92] = {99,0,0,0,0,99,99,1,1,0,0,0,0,2,2,99,99,3,3,1,1,1,1,2,2,2,2,5,5,99,6,6,6,6,3,3,4,4,4,4,5,5,5,5,9,9,6,6,6,6,7,7,7,7,8,8,8,8,9,9,9,9,99,10,10,10,10,11,11,11,11,12,12,12,12,99,99,13,13,13,13,14,14,14,14,99,99,15,15,15,15,99};
int cellToSquareB[92] = {99,99,99,99,99,99,99,99,99,1,1,2,2,99,99,99,99,99,99,3,3,4,4,4,4,5,5,99,99,99,99,99,3,3,7,7,7,7,8,8,8,8,9,9,99,99,99,99,10,10,10,10,11,11,11,11,12,12,12,12,99,99,99,99,99,13,13,13,13,14,14,14,14,99,99,99,99,99,99,15,15,15,15,99,99,99,99,99,99,99,99,99};

NSInteger secondsInt; //stopwatch timer count
NSTimer *timer; //stopwatch timer


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark - setters

- (void) setCurrentPuzzle:(Puzzle *)currentPuzzle
{
    _currentPuzzle = currentPuzzle;
    
}


#pragma mark - view lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.currentPuzzle) {
        self.puzzleView.puzzle = self.currentPuzzle; //Set the PuzzleView's puzzle
        
        [self.puzzleView.puzzle initSquaresWithCells];
        [self.puzzleView.puzzle initDiamondsWithCells];
        
    } else NSLog(@"No puzzle set for puzzleViewController");
    
    [self.puzzleView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self.puzzleView action:@selector(tap:)]];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //Set up parameters based on settings bundle
    
    self.enableBackgroundMusic = [[NSUserDefaults standardUserDefaults] boolForKey:BACKGROUND_MUSIC_KEY];
    self.enableSoundEffects = [[NSUserDefaults standardUserDefaults] boolForKey:SOUND_EFFECTS_KEY];
    self.useStopWatch = [[NSUserDefaults standardUserDefaults] boolForKey:STOPWATCH_KEY];
    self.puzzleView.useSolutionGuide = [[NSUserDefaults standardUserDefaults]boolForKey:SOLUTION_GUIDE_KEY];
    
    /* Load saved statistics bundle */
    [self loadStatistics];
    
    /* Setup background music and sound effects */
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    
    /* Background music */
    if (self.enableBackgroundMusic) {
        
        /* Overrides other music playing in the background */
        [audioSession setCategory:AVAudioSessionCategorySoloAmbient error:nil];
        [audioSession setActive:YES error:nil];
        
        NSString *musicFilePath = [[NSBundle mainBundle] pathForResource:@"Deliberate Thought" ofType:@"mp3"];
        NSURL *musicFileURL = [[NSURL alloc] initFileURLWithPath:musicFilePath];
        self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: musicFileURL error: nil];
        [self.backgroundMusicPlayer prepareToPlay];
        [self.backgroundMusicPlayer setNumberOfLoops:(-1)]; //Loop forever
        [self.backgroundMusicPlayer play];
        
    } else {
        /* Allows other music apps to play music in the background */
        [audioSession setCategory:AVAudioSessionCategoryAmbient error:nil];
        [audioSession setActive:YES error:nil];
        
    }
    
    /* Sound effects - only if setting is on and solution guide is on*/
    if ([[NSUserDefaults standardUserDefaults] boolForKey:SOUND_EFFECTS_KEY] && [[NSUserDefaults standardUserDefaults] boolForKey:SOLUTION_GUIDE_KEY]) {
        
        self.enableSoundEffects = YES;
        
        /* Button click */
        NSString *buttonClickFilePath = [[NSBundle mainBundle] pathForResource:@"buttonclick" ofType:@"mp3"];
        NSURL *buttonClickFileURL = [[NSURL alloc] initFileURLWithPath:buttonClickFilePath];
        self.buttonClickPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:buttonClickFileURL error:nil];
        [self.buttonClickPlayer prepareToPlay];
        [self.buttonClickPlayer setNumberOfLoops:0];  //Set it up to play once a button is clicked
        
        /*Square or Diamond section solved*/
        NSString *sectionSolvedFilePath = [[NSBundle mainBundle] pathForResource:@"section solved" ofType:@"mp3"];
        NSURL *sectionSolvedFileURL = [[NSURL alloc] initFileURLWithPath:sectionSolvedFilePath];
        self.sectionSolvedPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:sectionSolvedFileURL error:nil];
        [self.sectionSolvedPlayer prepareToPlay];
        [self.sectionSolvedPlayer setNumberOfLoops:0]; //Set it up to play once a square or diamond is solved
        
        /*Puzzle solved*/
        NSString *puzzleSolvedFilePath = [[NSBundle mainBundle] pathForResource:@"puzzle solved" ofType:@"mp3"];
        NSURL *puzzleSolvedFileURL = [[NSURL alloc] initFileURLWithPath:puzzleSolvedFilePath];
        self.puzzleSolvedPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:puzzleSolvedFileURL error:nil];
        [self.puzzleSolvedPlayer prepareToPlay];
        [self.puzzleSolvedPlayer setNumberOfLoops:1]; //Set it up to play once the puzzle is solved
    } else {

        self.enableSoundEffects = NO;
    }
    
    //Start the stopwatch timer but only show it if settings option is set
    [self startTimer:self.beginSeconds];  // start it with the timer where it was last left off.
    if (self.useStopWatch) {
        [self.stopWatchTimer setTextColor:[UIColor blackColor]];

    } else {
        //Make the label go disappear by setting color to clear
        [self.stopWatchTimer setTextColor:[UIColor clearColor]];
    }
    
    [self.puzzleView setNeedsDisplay];

}

- (void) viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [timer invalidate];  //cancel the timer
    
    if (!self.puzzleView.puzzle.solved) {   //If not solved yet then save the puzzle
        
        self.puzzleView.puzzle.savedTimer = secondsInt; //save the current stopwatch time
        self.beginSeconds = secondsInt; //also save it here in case the puzzleView returns from the settings view
    
        //Save the progress when the view goes offscreen
        [self saveInProgressPuzzle];
    
        if (self.backgroundMusicPlayer) {
            [self.backgroundMusicPlayer stop];  //stop the music
        }
        
    } else {    //If solved then delete the saved file
        
        [self deleteSavedPuzzle];
    }
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"SettingsFromPuzzle"]) {
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    }
}


#pragma mark On screen timer methods

- (void) startTimer:(NSInteger)beginTime {
    secondsInt = beginTime;   //Initialize it with the timer value where the user last left off
    [self refreshTimer];  // Initialize the timer label
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshTimer) userInfo:nil repeats:YES];
    
}

- (void)refreshTimer {
    
    NSInteger stopWatchHours = labs(secondsInt / 60);
    NSInteger stopWatchMin = fmod(secondsInt, 60);
    
    self.stopWatchTimer.text = [NSString stringWithFormat:@"%li:%02li", (long)stopWatchHours, (long)stopWatchMin];
    secondsInt +=1 ;
    
}

#pragma mark - Saved file management

- (void)saveInProgressPuzzle {
    
    if (self.puzzleView.puzzle == nil) return;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataFile = [documentsDirectory stringByAppendingPathComponent:@"puzzleData"];
    
    BOOL success = [NSKeyedArchiver archiveRootObject:self.puzzleView.puzzle toFile:dataFile];     //write current puzzle to archive file
    
    if (!success) {
        NSLog(@"Problem with archiving data");
    }
    
}

-(void)saveStatistics {
    
    /* Setup and save stats to file */
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataFile = [documentsDirectory stringByAppendingPathComponent:@"statsData"];
    
    BOOL success = [NSKeyedArchiver archiveRootObject:self.currentStats toFile:dataFile];     //write current stats to archive file
    
    if (!success) {
        NSLog(@"Problem with archiving stats data");
    }

}

-(void)loadStatistics {
    
    /* Load stats from saved file if it exists */
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataFile = [documentsDirectory stringByAppendingPathComponent:@"statsData"];
    
    if ( [[NSFileManager defaultManager]fileExistsAtPath:dataFile] ) {
        
        self.currentStats = [NSKeyedUnarchiver unarchiveObjectWithFile:dataFile];
        
        if (self.currentStats == nil) {  // If data file exists but stats haven't been setup yet
            self.currentStats = [[Statistics alloc]init];
        }
        
    } else {
        self.currentStats = [[Statistics alloc]init];
        [self.currentStats reset];
    }

}

-(void)deleteSavedPuzzle {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataFile = [documentsDirectory stringByAppendingPathComponent:@"puzzleData"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:dataFile error:NULL];
    
}


#pragma mark - other methods

- (IBAction)numberButton:(UIButton *)sender {     /* Process number entry from keypad */
    
    if (self.puzzleView.cellIndexSelected<=91) {    /* Only recognize the number button selected if a valid cell is selected */
        
    if (self.enableSoundEffects) {
        [self.buttonClickPlayer play];
    } // Play sound effect if enabled
        
    NSString *titleString = [[NSString alloc]initWithString:sender.currentTitle];
    int entry = [titleString intValue];
    int cellindex = self.puzzleView.cellIndexSelected;
    [self.puzzleView.puzzle.cells[cellindex] setCellContents:entry];


    /* Check whether diamond was solved by the entry just made */
    int diamondIndex = cellToDiamond[cellindex];
    BOOL diamondSolved = [self.puzzleView.puzzle.diamonds[diamondIndex] isSolved ];
        
    /* If diamond was solved and Sound Effect setting is enabled then play sound effect */
    if (self.enableSoundEffects && diamondSolved) {
        [self.sectionSolvedPlayer play];
    }
        
    /* Set the solved property on each of the member cells to the whether diamond is solved */
    
    [[ [self.puzzleView.puzzle.diamonds[diamondIndex] cellArray] objectAtIndex:0] setSolved:diamondSolved] ;
    [[ [self.puzzleView.puzzle.diamonds[diamondIndex] cellArray] objectAtIndex:1] setSolved:diamondSolved] ;
    [[ [self.puzzleView.puzzle.diamonds[diamondIndex] cellArray] objectAtIndex:2] setSolved:diamondSolved] ;
    [[ [self.puzzleView.puzzle.diamonds[diamondIndex] cellArray] objectAtIndex:3] setSolved:diamondSolved] ;
        
    /* Check whether one or two possible overlapping squares were solved by the entry just made */
    /* If either square index is 99 cell is not part of that square */
    int squareAIndex = cellToSquareA[cellindex];
    int squareBIndex = cellToSquareB[cellindex];
        
    if (squareAIndex != 99) {
        BOOL squareASolved = [self.puzzleView.puzzle.squares[squareAIndex] isSolved];
        if (squareASolved && self.enableSoundEffects) { [self.sectionSolvedPlayer play]; }
        }
        
    if (squareBIndex != 99) {
        BOOL squareBSolved = [self.puzzleView.puzzle.squares[squareBIndex] isSolved];
        if (squareBSolved && self.enableSoundEffects) { [self.sectionSolvedPlayer play]; }
    }
        
    [self.puzzleView setCellIndexSelected:100];    /* Turn off cell selection highlight*/
    [self.puzzleView setNeedsDisplay];
    
    // Finally, check to see if the puzzle is now solved
    [self puzzleSolvedCheck];
        
        
    }
    
}

- (void)puzzleSolvedCheck {
    //Test to see if puzzle is solved
    BOOL squaresSolved = true;
    BOOL diamondsSolved = true;
    
    for (Square *puzzleSquare in self.puzzleView.puzzle.squares) {
        if (puzzleSquare.solved == false) {
            squaresSolved = false;
        }
    }
    for (Diamond *puzzleDiamond in self.puzzleView.puzzle.diamonds) {
        if (puzzleDiamond.solved == false) {
            diamondsSolved = false;
        }
    }
    
    if (squaresSolved && diamondsSolved) {  // Actions to take if puzzle is solved
        
        self.puzzleView.puzzle.solved = YES;
        
        // Stop the timer if it is being used
        if (timer) {
            [timer invalidate];
        }
        
        // Stop background music
        [self.backgroundMusicPlayer stop];
        
        // Play puzzle solved sound if sound effects enabled
        if (self.enableSoundEffects) { [self.puzzleSolvedPlayer play]; }
        
        // Save stats to Statistics data file - only if timer setting is on
        if (self.useStopWatch) {
            switch (self.puzzleView.puzzle.difficultyLevel-1) {
            case 0:
                self.currentStats.level1PuzzlesSolved +=1;
                self.currentStats.level1TotalTime = self.currentStats.level1TotalTime + secondsInt;
                
                if (self.currentStats.level1RecordTime == 0) {
                    self.currentStats.level1RecordTime = secondsInt;
                } else {
                    self.currentStats.level1RecordTime = MIN(self.currentStats.level1RecordTime, secondsInt);
                }
                
                break;
            case 1:
                self.currentStats.level2PuzzlesSolved +=1;
                self.currentStats.level2TotalTime = self.currentStats.level2TotalTime + secondsInt;
                
                if (self.currentStats.level2RecordTime == 0) {
                    self.currentStats.level2RecordTime = secondsInt;
                } else {
                    self.currentStats.level2RecordTime = MIN(self.currentStats.level2RecordTime, secondsInt);
                }
                
                break;
            case 2:
                self.currentStats.level3PuzzlesSolved +=1;
                self.currentStats.level3TotalTime = self.currentStats.level3TotalTime + secondsInt;
                
                if (self.currentStats.level3RecordTime == 0) {
                    self.currentStats.level3RecordTime = secondsInt;
                } else {
                    self.currentStats.level3RecordTime = MIN(self.currentStats.level3RecordTime, secondsInt);
                }
                
                break;
            case 3:
                self.currentStats.level4PuzzlesSolved +=1;
                self.currentStats.level4TotalTime = self.currentStats.level4TotalTime + secondsInt;
                
                if (self.currentStats.level4RecordTime == 0) {
                    self.currentStats.level4RecordTime = secondsInt;
                } else {
                    self.currentStats.level4RecordTime = MIN(self.currentStats.level4RecordTime, secondsInt);
                }
                
                break;
            default:
                break;
            }
            [self saveStatistics];
        }
        
        // Show alert message - check to see if a new record was set
        NSString *alertMessage;
        if (self.currentStats.level1RecordTime == secondsInt) {
            alertMessage = @"The puzzle is solved.\nYou set a new record for level 1!";
        } else if (self.currentStats.level2RecordTime == secondsInt) {
            alertMessage = @"The puzzle is solved.\nYou set a new record for level 2!";
        } else if (self.currentStats.level3RecordTime == secondsInt) {
            alertMessage = @"The puzzle is solved.\nYou set a new record for level 3!";
        } else if (self.currentStats.level4RecordTime == secondsInt) {
            alertMessage = @"The puzzle is solved.\nYou set a new record for level 4!";
        } else {
            alertMessage = @"The puzzle is solved.";
        }
        [self alert:@"Congratulations!" withMessage:alertMessage];
        
        }
}


-(void) alert:(NSString *)title withMessage:(NSString *)msg
{
    [[[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {     //User clicked the OK button when the puzzle solved alert was shown
    
    // Dismiss the PuzzleView and go back to the main ViewController
    [self.navigationController popViewControllerAnimated:YES];

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
