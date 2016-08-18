//
//  PuzzleView.h
//  Dezoito
//
//  Created by Ed Ballington on 8/22/14.
//  Copyright (c) 2014 Ed Ballington. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Puzzle.h"
#import "Diamond.h"
#import "Square.h"

@interface PuzzleView : UIView

@property (strong, nonatomic) Puzzle *puzzle;

@property (nonatomic) int cellIndexSelected;  /* Index of cell selected for input */

@property (strong, nonatomic) NSMutableArray *cellPaths;  /* Array to contain the Bezier Paths defining each of the cells */

@property (nonatomic) BOOL useSolutionGuide;  //settings preference to use solution guide or not

-(void)tap:(UITapGestureRecognizer *)gesture;


@end
