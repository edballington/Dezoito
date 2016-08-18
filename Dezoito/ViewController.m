//
//  ViewController.m
//  Dezoito
//
//  Created by Ed Ballington on 5/13/14.
//  Copyright (c) 2014 Ed Ballington. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIActionSheet *actionSheet;
@property (strong, nonatomic) UIAlertView *alertView;

@end

@implementation ViewController 

NSDictionary *puzzleList;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load the puzzles from property list
    NSString *path = [[NSBundle mainBundle] pathForResource:@"puzzlelist" ofType:@"plist"];
    puzzleList = [[NSDictionary alloc]initWithContentsOfFile:path];
    
    if (!puzzleList) {
        NSLog(@"Error - no puzzle file exists");
        // Any other error procedures to do here??
    }
    
    self.dezoitoImageView.image = [UIImage imageNamed:@"DezoitoImage.png"];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    /* Add notification to close alert view or action sheet if open when application enters background */
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dismissAlertandActionSheetOnBackground)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];

    
    /* The below lines round off the corners of the New Game and Resume Game buttons */
    [self.startGameButton.layer setCornerRadius:15.0f];
    [self.startGameButton.layer setMasksToBounds:YES];
    [self.resumeGameButton.layer setCornerRadius:15.0f];
    [self.resumeGameButton.layer setMasksToBounds:YES];
    
    
    /* returns nil if there is no saved puzzle because puzzle was solved or this is the first time */

    if ([self loadSavedPuzzle]) {
        self.resumeGameButton.enabled = YES;
        self.resumeGameButton.titleLabel.alpha = 1.0;
    } else {
        self.resumeGameButton.enabled = NO;
        self.resumeGameButton.titleLabel.alpha = 0.3;  // Dim the text if there is no puzzle to resume
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    
    //Remove notification used for dismissing ActionSheet
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}


#pragma mark - Actions

- (IBAction)newGame:(id)sender {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataFile = [documentsDirectory stringByAppendingPathComponent:@"puzzleData"];
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:dataFile];
    
    if (fileExists) { [self alert:@"Puzzle In Progress" withMessage:@"This will delete the puzzle already in progress."]; }
    else { [self getDifficultyLevel]; }
    
}

-(void)getDifficultyLevel
{
    
    self.actionSheet = [[UIActionSheet alloc]initWithTitle:@"Select Difficulty Level"
                                                                            delegate:self
                                                                   cancelButtonTitle:@"Cancel"
                                                              destructiveButtonTitle:nil
                                                                   otherButtonTitles:@"1 - Easy", @"2 - Medium", @"3 - Hard", @"4 - Expert", nil];
    [self.actionSheet showInView:self.view];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {     //New Puzzle button
        
        [self getDifficultyLevel];
        
    } else {                    //Cancel button
        
        nil;
    }
    
}

-(void)dismissAlertandActionSheetOnBackground
{
        if (self.alertView) {
        [self.alertView dismissWithClickedButtonIndex:self.alertView.cancelButtonIndex animated:YES];
    }
        if (self.actionSheet) {
        [self.actionSheet dismissWithClickedButtonIndex:self.actionSheet.cancelButtonIndex animated:YES];
    }

}


#pragma mark - Other methods

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            NSLog(@"Easy");
            [self performSegueWithIdentifier:@"Difficulty1" sender:self];
            break;
        case 1:
            NSLog(@"Medium");
            [self performSegueWithIdentifier:@"Difficulty2" sender:self];
            break;
        case 2:
            NSLog(@"Hard");
            [self performSegueWithIdentifier:@"Difficulty3" sender:self];
            break;
        case 3:
            NSLog(@"Expert");
            [self performSegueWithIdentifier:@"Difficulty4" sender:self];
            break;
        default:
            break;
    }
}

-(void) alert:(NSString *)title withMessage:(NSString *)msg
{
    self.alertView = [[UIAlertView alloc] initWithTitle:title message:msg
                               delegate:self
                      cancelButtonTitle:@"Cancel"
                      otherButtonTitles:@"New Puzzle", nil];
     
    [self.alertView show];
}

-(Puzzle*)loadSavedPuzzle
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataFile = [documentsDirectory stringByAppendingPathComponent:@"puzzleData"];
    
    Puzzle *savedPuzzle = [NSKeyedUnarchiver unarchiveObjectWithFile:dataFile];
    return savedPuzzle;
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    Puzzle *randomPuzzle;
    Puzzle *savedPuzzle;
    
    if ([segue.identifier isEqualToString:@"Difficulty1"]) {
        if ([segue.destinationViewController isKindOfClass:[PuzzleViewController class]]) {
            randomPuzzle = [self selectPuzzleWithDifficulty:@"1"];
            [[segue destinationViewController] setCurrentPuzzle:randomPuzzle];
            [[segue destinationViewController] setTitle:@"Level 1"];
            [[segue destinationViewController] setBeginSeconds:0];
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Back/Pause" style:UIBarButtonItemStyleBordered target:nil action:nil];
        }
    } else if ([segue.identifier isEqualToString:@"Difficulty2"]) {
        if ([segue.destinationViewController isKindOfClass:[PuzzleViewController class]]) {
            randomPuzzle = [self selectPuzzleWithDifficulty:@"2"];
            [[segue destinationViewController] setCurrentPuzzle:randomPuzzle];
            [[segue destinationViewController] setTitle:@"Level 2"];
            [[segue destinationViewController] setBeginSeconds:0];
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Back/Pause" style:UIBarButtonItemStyleBordered target:nil action:nil];
        }
    } else if ([segue.identifier isEqualToString:@"Difficulty3"]) {
        if ([segue.destinationViewController isKindOfClass:[PuzzleViewController class]]) {
            randomPuzzle = [self selectPuzzleWithDifficulty:@"3"];
            [[segue destinationViewController] setCurrentPuzzle:randomPuzzle];
            [[segue destinationViewController] setTitle:@"Level 3"];
            [[segue destinationViewController] setBeginSeconds:0];
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Back/Pause" style:UIBarButtonItemStyleBordered target:nil action:nil];
        }
    } else if ([segue.identifier isEqualToString:@"Difficulty4"]) {
        if ([segue.destinationViewController isKindOfClass:[PuzzleViewController class]]) {
            randomPuzzle = [self selectPuzzleWithDifficulty:@"4"];
            [[segue destinationViewController] setCurrentPuzzle:randomPuzzle];
            [[segue destinationViewController] setTitle:@"Level 4"];
            [[segue destinationViewController] setBeginSeconds:0];
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Back/Pause" style:UIBarButtonItemStyleBordered target:nil action:nil];
        }
    
    } else if ([segue.identifier isEqualToString:@"Resume Game"]) {
        if ([segue.destinationViewController isKindOfClass:[PuzzleViewController class]]) {
            savedPuzzle = [self loadSavedPuzzle];
            [[segue destinationViewController] setCurrentPuzzle:savedPuzzle];
            [[segue destinationViewController] setTitle:[NSString stringWithFormat:@"Level %i", savedPuzzle.difficultyLevel]];
            [[segue destinationViewController] setBeginSeconds:savedPuzzle.savedTimer];
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Back/Pause" style:UIBarButtonItemStyleBordered target:nil action:nil];
        }
    } else if ([segue.identifier isEqualToString:@"About"] || [segue.identifier isEqualToString:@"HowToPlay"] || [segue.identifier isEqualToString:@"Settings"] || [segue.identifier isEqualToString:@"Statistics"]) {
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    } else {
        NSLog(@"Invalid segue identifier");
        randomPuzzle = nil;
    }
    
}

- (Puzzle *)selectPuzzleWithDifficulty:(NSString *)difficulty         //Return a random puzzle from puzzlelist
{
    
    NSArray *refNumberArray = [[puzzleList objectForKey:difficulty] allKeys];   // Generate array of all puzzle reference number keys
    NSUInteger randomindex = arc4random_uniform( (u_int32_t) [refNumberArray count]); //random index
    NSString *refNumber = refNumberArray[randomindex]; //random ref number to get puzzle
    
    NSArray *selectedPuzzleArray = [[puzzleList objectForKey:difficulty]objectForKey:refNumber];
    
    Puzzle *puzzle = [[Puzzle alloc]initPuzzleWithCells:selectedPuzzleArray]; //Generate Puzzle object from randomly selected puzzle array
    puzzle.difficultyLevel = [difficulty intValue];
    return puzzle;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
