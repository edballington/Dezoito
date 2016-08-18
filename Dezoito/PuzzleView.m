//
//  PuzzleView.m
//  Dezoito
//
//  Created by Ed Ballington on 8/22/14.
//  Copyright (c) 2014 Ed Ballington. All rights reserved.
//

#import "PuzzleView.h"

#define BOX_SCALE_FACTOR 0.25 /*scale of box size relative to cell size */
#define CELL_LINE_COLOR blackColor /*color of cell borders */
#define CELL_SELECTED_COLOR redColor /*highlight border of cell selected for input */
#define CELL_SELECTED_WIDTH 3.0  /* line width of border of cell selected for input */
#define CELL_FILL_COLOR clearColor /*color of cell fill */
#define PUZZLE_BKGRD_COLOR yellowColor /*color of puzzle background */
#define CELL_SOLVED_COLOR greenColor /*fill color of solved cell */
#define SQUARE_SOLVED_COLOR greenColor /*fill color of box for solved square */
#define CELL_CONTENTS_FONT @"BradleyHandITCTT-Bold" /* default font for cell contents */
#define CELL_CONTENTS_COLOR blackColor /* color of entered cell contents */
#define CELL_CONTENTS_LOCKED_COLOR brownColor /* color of locked cell contents */
#define CELL_CONTENTS_SCALE_FACTOR 0.95 /* scale of cell contents font relative to cell size */




@implementation PuzzleView

CGFloat cellSize;
CGFloat boxSize;
CGFloat squareLineWidth;
CGFloat diamondLineWidth;
CGFloat dashes[] = {6, 6};
CGFloat cellSelectedLineWidth;
UIColor *cellLineColor;
UIColor *cellFillColor;
UIColor *cellSelectedColor;
UIColor *cellSolvedFillColor;
UIColor *squareSolvedColor;
UIColor *puzzleBackgroundColor;
UIColor *enteredCellFontColor;
UIColor *lockedCellFontColor;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
       }
    return self;
}

- (void) awakeFromNib
{
    [self setup];
}

// View setup code //
-(void) setup
{
    
    self.cellPaths = [[NSMutableArray alloc]init];
    self.cellIndexSelected=100; /* This means no cell is selected starting out (100 is invalid cell) */
    
    for (NSUInteger n=0; n<=91; n++)
        {
            [self.cellPaths addObject:[[UIBezierPath alloc]init]];
        }
    
    /* Size, color, and line type drawing variables */
    cellSize = self.bounds.size.width/8;  /*8 cells across */
    boxSize = cellSize*BOX_SCALE_FACTOR; /* box to draw cell contents in */
    squareLineWidth = 1.0;
    diamondLineWidth = 1.0;
    cellLineColor = [UIColor CELL_LINE_COLOR];
    cellFillColor = [UIColor CELL_FILL_COLOR];
    cellSelectedColor = [UIColor CELL_SELECTED_COLOR];
    cellSelectedLineWidth = CELL_SELECTED_WIDTH;
    cellSolvedFillColor = [UIColor CELL_SOLVED_COLOR];
    squareSolvedColor = [UIColor SQUARE_SOLVED_COLOR];
    puzzleBackgroundColor = [UIColor PUZZLE_BKGRD_COLOR];
    enteredCellFontColor = [UIColor CELL_CONTENTS_COLOR];
    lockedCellFontColor = [UIColor CELL_CONTENTS_LOCKED_COLOR];
    
}

- (void)drawRect:(CGRect)rect
{

#pragma mark Define and draw cell boundaries
    
    // Drawing code for puzzle grid - leave lines unstroked so dashed and solid lines can be drawn separately.
    
    /* path variable names match corresponding cell numbers */
  
    [self.cellPaths[0] moveToPoint:CGPointMake(3*cellSize, 0)];
    [self.cellPaths[0] addLineToPoint:CGPointMake(3*cellSize, cellSize)];
    [self.cellPaths[0] addLineToPoint:CGPointMake(2*cellSize, cellSize)];
    [self.cellPaths[0] closePath];
    
    [self.cellPaths[1] moveToPoint:CGPointMake(3*cellSize, 0)];
    [self.cellPaths[1] addLineToPoint:CGPointMake(3*cellSize, cellSize)];
    [self.cellPaths[1] addLineToPoint:CGPointMake(4*cellSize, cellSize)];
    [self.cellPaths[1] closePath];
    
    [self.cellPaths[2] moveToPoint:CGPointMake(3*cellSize, 0)];
    [self.cellPaths[2] addLineToPoint:CGPointMake(4*cellSize, 0)];
    [self.cellPaths[2] addLineToPoint:CGPointMake(4*cellSize, cellSize)];
    [self.cellPaths[2] closePath];

    [self.cellPaths[3] moveToPoint:CGPointMake(4*cellSize, cellSize)];
    [self.cellPaths[3] addLineToPoint:CGPointMake(4*cellSize, 0)];
    [self.cellPaths[3] addLineToPoint:CGPointMake(5*cellSize, 0)];
    [self.cellPaths[3] closePath];
    
    [self.cellPaths[4] moveToPoint:CGPointMake(4*cellSize, cellSize)];
    [self.cellPaths[4] addLineToPoint:CGPointMake(5*cellSize, cellSize)];
    [self.cellPaths[4] addLineToPoint:CGPointMake(5*cellSize, 0)];
    [self.cellPaths[4] closePath];
    
    [self.cellPaths[5] moveToPoint:CGPointMake(5*cellSize, 0)];
    [self.cellPaths[5] addLineToPoint:CGPointMake(5*cellSize, cellSize)];
    [self.cellPaths[5] addLineToPoint:CGPointMake(6*cellSize, cellSize)];
    [self.cellPaths[5] closePath];
    
    [self.cellPaths[6] moveToPoint:CGPointMake(cellSize, 2*cellSize)];
    [self.cellPaths[6] addLineToPoint:CGPointMake(2*cellSize, 2*cellSize)];
    [self.cellPaths[6] addLineToPoint:CGPointMake(2*cellSize, cellSize)];
    [self.cellPaths[6] closePath];
    
    [self.cellPaths[7] moveToPoint:CGPointMake(2*cellSize, cellSize)];
    [self.cellPaths[7] addLineToPoint:CGPointMake(2*cellSize, 2*cellSize)];
    [self.cellPaths[7] addLineToPoint:CGPointMake(3*cellSize, 2*cellSize)];
    [self.cellPaths[7] closePath];

    [self.cellPaths[8] moveToPoint:CGPointMake(2*cellSize, cellSize)];
    [self.cellPaths[8] addLineToPoint:CGPointMake(3*cellSize, cellSize)];
    [self.cellPaths[8] addLineToPoint:CGPointMake(3*cellSize, 2*cellSize)];
    [self.cellPaths[8] closePath];
    
    [self.cellPaths[9] moveToPoint:CGPointMake(3*cellSize, 2*cellSize)];
    [self.cellPaths[9] addLineToPoint:CGPointMake(3*cellSize, cellSize)];
    [self.cellPaths[9] addLineToPoint:CGPointMake(4*cellSize, cellSize)];
    [self.cellPaths[9] closePath];
    
    [self.cellPaths[10] moveToPoint:CGPointMake(3*cellSize, 2*cellSize)];
    [self.cellPaths[10] addLineToPoint:CGPointMake(4*cellSize, 2*cellSize)];
    [self.cellPaths[10] addLineToPoint:CGPointMake(4*cellSize, cellSize)];
    [self.cellPaths[10] closePath];

    [self.cellPaths[11] moveToPoint:CGPointMake(4*cellSize, cellSize)];
    [self.cellPaths[11] addLineToPoint:CGPointMake(4*cellSize, 2*cellSize)];
    [self.cellPaths[11] addLineToPoint:CGPointMake(5*cellSize, 2*cellSize)];
    [self.cellPaths[11] closePath];
    
    [self.cellPaths[12] moveToPoint:CGPointMake(4*cellSize, cellSize)];
    [self.cellPaths[12] addLineToPoint:CGPointMake(5*cellSize, cellSize)];
    [self.cellPaths[12] addLineToPoint:CGPointMake(5*cellSize, 2*cellSize)];
    [self.cellPaths[12] closePath];

    [self.cellPaths[13] moveToPoint:CGPointMake(5*cellSize, 2*cellSize)];
    [self.cellPaths[13] addLineToPoint:CGPointMake(5*cellSize, cellSize)];
    [self.cellPaths[13] addLineToPoint:CGPointMake(6*cellSize, cellSize)];
    [self.cellPaths[13] closePath];
    
    [self.cellPaths[14] moveToPoint:CGPointMake(5*cellSize, 2*cellSize)];
    [self.cellPaths[14] addLineToPoint:CGPointMake(6*cellSize, 2*cellSize)];
    [self.cellPaths[14] addLineToPoint:CGPointMake(6*cellSize, cellSize)];
    [self.cellPaths[14] closePath];

    [self.cellPaths[15] moveToPoint:CGPointMake(6*cellSize, cellSize)];
    [self.cellPaths[15] addLineToPoint:CGPointMake(6*cellSize, 2*cellSize)];
    [self.cellPaths[15] addLineToPoint:CGPointMake(7*cellSize, 2*cellSize)];
    [self.cellPaths[15] closePath];
    
    [self.cellPaths[16] moveToPoint:CGPointMake(0, 3*cellSize)];
    [self.cellPaths[16] addLineToPoint:CGPointMake(cellSize, 3*cellSize)];
    [self.cellPaths[16] addLineToPoint:CGPointMake(cellSize, 2*cellSize)];
    [self.cellPaths[16] closePath];
    
    [self.cellPaths[17] moveToPoint:CGPointMake(cellSize, 2*cellSize)];
    [self.cellPaths[17] addLineToPoint:CGPointMake(cellSize, 3*cellSize)];
    [self.cellPaths[17] addLineToPoint:CGPointMake(2*cellSize, 3*cellSize)];
    [self.cellPaths[17] closePath];
    
    [self.cellPaths[18] moveToPoint:CGPointMake(cellSize, 2*cellSize)];
    [self.cellPaths[18] addLineToPoint:CGPointMake(2*cellSize, 2*cellSize)];
    [self.cellPaths[18] addLineToPoint:CGPointMake(2*cellSize, 3*cellSize)];
    [self.cellPaths[18] closePath];

    [self.cellPaths[19] moveToPoint:CGPointMake(2*cellSize, 3*cellSize)];
    [self.cellPaths[19] addLineToPoint:CGPointMake(2*cellSize, 2*cellSize)];
    [self.cellPaths[19] addLineToPoint:CGPointMake(3*cellSize, 2*cellSize)];
    [self.cellPaths[19] closePath];

    [self.cellPaths[20] moveToPoint:CGPointMake(2*cellSize, 3*cellSize)];
    [self.cellPaths[20] addLineToPoint:CGPointMake(3*cellSize, 3*cellSize)];
    [self.cellPaths[20] addLineToPoint:CGPointMake(3*cellSize, 2*cellSize)];
    [self.cellPaths[20] closePath];

    [self.cellPaths[21] moveToPoint:CGPointMake(3*cellSize, 2*cellSize)];
    [self.cellPaths[21] addLineToPoint:CGPointMake(3*cellSize, 3*cellSize)];
    [self.cellPaths[21] addLineToPoint:CGPointMake(4*cellSize, 3*cellSize)];
    [self.cellPaths[21] closePath];
    
    [self.cellPaths[22] moveToPoint:CGPointMake(3*cellSize, 2*cellSize)];
    [self.cellPaths[22] addLineToPoint:CGPointMake(4*cellSize, 2*cellSize)];
    [self.cellPaths[22] addLineToPoint:CGPointMake(4*cellSize, 3*cellSize)];
    [self.cellPaths[22] closePath];

    [self.cellPaths[23] moveToPoint:CGPointMake(4*cellSize, 3*cellSize)];
    [self.cellPaths[23] addLineToPoint:CGPointMake(4*cellSize, 2*cellSize)];
    [self.cellPaths[23] addLineToPoint:CGPointMake(5*cellSize, 2*cellSize)];
    [self.cellPaths[23] closePath];
    
    [self.cellPaths[24] moveToPoint:CGPointMake(4*cellSize, 3*cellSize)];
    [self.cellPaths[24] addLineToPoint:CGPointMake(5*cellSize, 3*cellSize)];
    [self.cellPaths[24] addLineToPoint:CGPointMake(5*cellSize, 2*cellSize)];
    [self.cellPaths[24] closePath];
    
    [self.cellPaths[25] moveToPoint:CGPointMake(5*cellSize, 2*cellSize)];
    [self.cellPaths[25] addLineToPoint:CGPointMake(5*cellSize, 3*cellSize)];
    [self.cellPaths[25] addLineToPoint:CGPointMake(6*cellSize, 3*cellSize)];
    [self.cellPaths[25] closePath];
    
    [self.cellPaths[26] moveToPoint:CGPointMake(5*cellSize, 2*cellSize)];
    [self.cellPaths[26] addLineToPoint:CGPointMake(6*cellSize, 2*cellSize)];
    [self.cellPaths[26] addLineToPoint:CGPointMake(6*cellSize, 3*cellSize)];
    [self.cellPaths[26] closePath];
    
    [self.cellPaths[27] moveToPoint:CGPointMake(6*cellSize, 3*cellSize)];
    [self.cellPaths[27] addLineToPoint:CGPointMake(6*cellSize, 2*cellSize)];
    [self.cellPaths[27] addLineToPoint:CGPointMake(7*cellSize, 2*cellSize)];
    [self.cellPaths[27] closePath];
    
    [self.cellPaths[28] moveToPoint:CGPointMake(6*cellSize, 3*cellSize)];
    [self.cellPaths[28] addLineToPoint:CGPointMake(7*cellSize, 3*cellSize)];
    [self.cellPaths[28] addLineToPoint:CGPointMake(7*cellSize, 2*cellSize)];
    [self.cellPaths[28] closePath];

    [self.cellPaths[29] moveToPoint:CGPointMake(7*cellSize, 2*cellSize)];
    [self.cellPaths[29] addLineToPoint:CGPointMake(7*cellSize, 3*cellSize)];
    [self.cellPaths[29] addLineToPoint:CGPointMake(8*cellSize, 3*cellSize)];
    [self.cellPaths[29] closePath];
    
    [self.cellPaths[30] moveToPoint:CGPointMake(0, 3*cellSize)];
    [self.cellPaths[30] addLineToPoint:CGPointMake(0, 4*cellSize)];
    [self.cellPaths[30] addLineToPoint:CGPointMake(cellSize, 4*cellSize)];
    [self.cellPaths[30] closePath];
    
    [self.cellPaths[31] moveToPoint:CGPointMake(0, 3*cellSize)];
    [self.cellPaths[31] addLineToPoint:CGPointMake(cellSize, 3*cellSize)];
    [self.cellPaths[31] addLineToPoint:CGPointMake(cellSize, 4*cellSize)];
    [self.cellPaths[31] closePath];

    [self.cellPaths[32] moveToPoint:CGPointMake(cellSize, 4*cellSize)];
    [self.cellPaths[32] addLineToPoint:CGPointMake(cellSize, 3*cellSize)];
    [self.cellPaths[32] addLineToPoint:CGPointMake(2*cellSize, 3*cellSize)];
    [self.cellPaths[32] closePath];

    [self.cellPaths[33] moveToPoint:CGPointMake(cellSize, 4*cellSize)];
    [self.cellPaths[33] addLineToPoint:CGPointMake(2*cellSize, 4*cellSize)];
    [self.cellPaths[33] addLineToPoint:CGPointMake(2*cellSize, 3*cellSize)];
    [self.cellPaths[33] closePath];
    
    [self.cellPaths[34] moveToPoint:CGPointMake(2*cellSize, 3*cellSize)];
    [self.cellPaths[34] addLineToPoint:CGPointMake(2*cellSize, 4*cellSize)];
    [self.cellPaths[34] addLineToPoint:CGPointMake(3*cellSize, 4*cellSize)];
    [self.cellPaths[34] closePath];

    [self.cellPaths[35] moveToPoint:CGPointMake(2*cellSize, 3*cellSize)];
    [self.cellPaths[35] addLineToPoint:CGPointMake(3*cellSize, 3*cellSize)];
    [self.cellPaths[35] addLineToPoint:CGPointMake(3*cellSize, 4*cellSize)];
    [self.cellPaths[35] closePath];

    [self.cellPaths[36] moveToPoint:CGPointMake(3*cellSize, 4*cellSize)];
    [self.cellPaths[36] addLineToPoint:CGPointMake(3*cellSize, 3*cellSize)];
    [self.cellPaths[36] addLineToPoint:CGPointMake(4*cellSize, 3*cellSize)];
    [self.cellPaths[36] closePath];
    
    [self.cellPaths[37] moveToPoint:CGPointMake(3*cellSize, 4*cellSize)];
    [self.cellPaths[37] addLineToPoint:CGPointMake(4*cellSize, 4*cellSize)];
    [self.cellPaths[37] addLineToPoint:CGPointMake(4*cellSize, 3*cellSize)];
    [self.cellPaths[37] closePath];

    [self.cellPaths[38] moveToPoint:CGPointMake(4*cellSize, 3*cellSize)];
    [self.cellPaths[38] addLineToPoint:CGPointMake(4*cellSize, 4*cellSize)];
    [self.cellPaths[38] addLineToPoint:CGPointMake(5*cellSize, 4*cellSize)];
    [self.cellPaths[38] closePath];
    
    [self.cellPaths[39] moveToPoint:CGPointMake(4*cellSize, 3*cellSize)];
    [self.cellPaths[39] addLineToPoint:CGPointMake(5*cellSize, 3*cellSize)];
    [self.cellPaths[39] addLineToPoint:CGPointMake(5*cellSize, 4*cellSize)];
    [self.cellPaths[39] closePath];

    [self.cellPaths[40] moveToPoint:CGPointMake(5*cellSize, 4*cellSize)];
    [self.cellPaths[40] addLineToPoint:CGPointMake(5*cellSize, 3*cellSize)];
    [self.cellPaths[40] addLineToPoint:CGPointMake(6*cellSize, 3*cellSize)];
    [self.cellPaths[40] closePath];

    [self.cellPaths[41] moveToPoint:CGPointMake(5*cellSize, 4*cellSize)];
    [self.cellPaths[41] addLineToPoint:CGPointMake(6*cellSize, 4*cellSize)];
    [self.cellPaths[41] addLineToPoint:CGPointMake(6*cellSize, 3*cellSize)];
    [self.cellPaths[41] closePath];

    [self.cellPaths[42] moveToPoint:CGPointMake(6*cellSize, 3*cellSize)];
    [self.cellPaths[42] addLineToPoint:CGPointMake(6*cellSize, 4*cellSize)];
    [self.cellPaths[42] addLineToPoint:CGPointMake(7*cellSize, 4*cellSize)];
    [self.cellPaths[42] closePath];

    [self.cellPaths[43] moveToPoint:CGPointMake(6*cellSize, 3*cellSize)];
    [self.cellPaths[43] addLineToPoint:CGPointMake(7*cellSize, 3*cellSize)];
    [self.cellPaths[43] addLineToPoint:CGPointMake(7*cellSize, 4*cellSize)];
    [self.cellPaths[43] closePath];

    [self.cellPaths[44] moveToPoint:CGPointMake(7*cellSize, 4*cellSize)];
    [self.cellPaths[44] addLineToPoint:CGPointMake(7*cellSize, 3*cellSize)];
    [self.cellPaths[44] addLineToPoint:CGPointMake(8*cellSize, 3*cellSize)];
    [self.cellPaths[44] closePath];

    [self.cellPaths[45] moveToPoint:CGPointMake(7*cellSize, 4*cellSize)];
    [self.cellPaths[45] addLineToPoint:CGPointMake(8*cellSize, 4*cellSize)];
    [self.cellPaths[45] addLineToPoint:CGPointMake(8*cellSize, 3*cellSize)];
    [self.cellPaths[45] closePath];

    [self.cellPaths[46] moveToPoint:CGPointMake(0, 5*cellSize)];
    [self.cellPaths[46] addLineToPoint:CGPointMake(0, 4*cellSize)];
    [self.cellPaths[46] addLineToPoint:CGPointMake(cellSize, 4*cellSize)];
    [self.cellPaths[46] closePath];

    [self.cellPaths[47] moveToPoint:CGPointMake(0, 5*cellSize)];
    [self.cellPaths[47] addLineToPoint:CGPointMake(cellSize, 5*cellSize)];
    [self.cellPaths[47] addLineToPoint:CGPointMake(cellSize, 4*cellSize)];
    [self.cellPaths[47] closePath];

    [self.cellPaths[48] moveToPoint:CGPointMake(cellSize, 4*cellSize)];
    [self.cellPaths[48] addLineToPoint:CGPointMake(cellSize, 5*cellSize)];
    [self.cellPaths[48] addLineToPoint:CGPointMake(2*cellSize, 5*cellSize)];
    [self.cellPaths[48] closePath];

    [self.cellPaths[49] moveToPoint:CGPointMake(cellSize, 4*cellSize)];
    [self.cellPaths[49] addLineToPoint:CGPointMake(2*cellSize, 4*cellSize)];
    [self.cellPaths[49] addLineToPoint:CGPointMake(2*cellSize, 5*cellSize)];
    [self.cellPaths[49] closePath];

    [self.cellPaths[50] moveToPoint:CGPointMake(2*cellSize, 5*cellSize)];
    [self.cellPaths[50] addLineToPoint:CGPointMake(2*cellSize, 4*cellSize)];
    [self.cellPaths[50] addLineToPoint:CGPointMake(3*cellSize, 4*cellSize)];
    [self.cellPaths[50] closePath];

    [self.cellPaths[51] moveToPoint:CGPointMake(2*cellSize, 5*cellSize)];
    [self.cellPaths[51] addLineToPoint:CGPointMake(3*cellSize, 5*cellSize)];
    [self.cellPaths[51] addLineToPoint:CGPointMake(3*cellSize, 4*cellSize)];
    [self.cellPaths[51] closePath];

    [self.cellPaths[52] moveToPoint:CGPointMake(3*cellSize, 4*cellSize)];
    [self.cellPaths[52] addLineToPoint:CGPointMake(3*cellSize, 5*cellSize)];
    [self.cellPaths[52] addLineToPoint:CGPointMake(4*cellSize, 5*cellSize)];
    [self.cellPaths[52] closePath];
    
    [self.cellPaths[53] moveToPoint:CGPointMake(3*cellSize, 4*cellSize)];
    [self.cellPaths[53] addLineToPoint:CGPointMake(4*cellSize, 4*cellSize)];
    [self.cellPaths[53] addLineToPoint:CGPointMake(4*cellSize, 5*cellSize)];
    [self.cellPaths[53] closePath];

    [self.cellPaths[54] moveToPoint:CGPointMake(4*cellSize, 5*cellSize)];
    [self.cellPaths[54] addLineToPoint:CGPointMake(4*cellSize, 4*cellSize)];
    [self.cellPaths[54] addLineToPoint:CGPointMake(5*cellSize, 4*cellSize)];
    [self.cellPaths[54] closePath];

    [self.cellPaths[55] moveToPoint:CGPointMake(4*cellSize, 5*cellSize)];
    [self.cellPaths[55] addLineToPoint:CGPointMake(5*cellSize, 5*cellSize)];
    [self.cellPaths[55] addLineToPoint:CGPointMake(5*cellSize, 4*cellSize)];
    [self.cellPaths[55] closePath];

    [self.cellPaths[56] moveToPoint:CGPointMake(5*cellSize, 4*cellSize)];
    [self.cellPaths[56] addLineToPoint:CGPointMake(5*cellSize, 5*cellSize)];
    [self.cellPaths[56] addLineToPoint:CGPointMake(6*cellSize, 5*cellSize)];
    [self.cellPaths[56] closePath];

    [self.cellPaths[57] moveToPoint:CGPointMake(5*cellSize, 4*cellSize)];
    [self.cellPaths[57] addLineToPoint:CGPointMake(6*cellSize, 4*cellSize)];
    [self.cellPaths[57] addLineToPoint:CGPointMake(6*cellSize, 5*cellSize)];
    [self.cellPaths[57] closePath];

    [self.cellPaths[58] moveToPoint:CGPointMake(6*cellSize, 5*cellSize)];
    [self.cellPaths[58] addLineToPoint:CGPointMake(6*cellSize, 4*cellSize)];
    [self.cellPaths[58] addLineToPoint:CGPointMake(7*cellSize, 4*cellSize)];
    [self.cellPaths[58] closePath];

    [self.cellPaths[59] moveToPoint:CGPointMake(6*cellSize, 5*cellSize)];
    [self.cellPaths[59] addLineToPoint:CGPointMake(7*cellSize, 5*cellSize)];
    [self.cellPaths[59] addLineToPoint:CGPointMake(7*cellSize, 4*cellSize)];
    [self.cellPaths[59] closePath];

    [self.cellPaths[60] moveToPoint:CGPointMake(7*cellSize, 4*cellSize)];
    [self.cellPaths[60] addLineToPoint:CGPointMake(7*cellSize, 5*cellSize)];
    [self.cellPaths[60] addLineToPoint:CGPointMake(8*cellSize, 5*cellSize)];
    [self.cellPaths[60] closePath];

    [self.cellPaths[61] moveToPoint:CGPointMake(7*cellSize, 4*cellSize)];
    [self.cellPaths[61] addLineToPoint:CGPointMake(8*cellSize, 4*cellSize)];
    [self.cellPaths[61] addLineToPoint:CGPointMake(8*cellSize, 5*cellSize)];
    [self.cellPaths[61] closePath];
    
    [self.cellPaths[62] moveToPoint:CGPointMake(0, 5*cellSize)];
    [self.cellPaths[62] addLineToPoint:CGPointMake(cellSize, 5*cellSize)];
    [self.cellPaths[62] addLineToPoint:CGPointMake(cellSize, 6*cellSize)];
    [self.cellPaths[62] closePath];
    
    [self.cellPaths[63] moveToPoint:CGPointMake(cellSize, 6*cellSize)];
    [self.cellPaths[63] addLineToPoint:CGPointMake(cellSize, 5*cellSize)];
    [self.cellPaths[63] addLineToPoint:CGPointMake(2*cellSize, 5*cellSize)];
    [self.cellPaths[63] closePath];
    
    [self.cellPaths[64] moveToPoint:CGPointMake(cellSize, 6*cellSize)];
    [self.cellPaths[64] addLineToPoint:CGPointMake(2*cellSize, 6*cellSize)];
    [self.cellPaths[64] addLineToPoint:CGPointMake(2*cellSize, 5*cellSize)];
    [self.cellPaths[64] closePath];
    
    [self.cellPaths[65] moveToPoint:CGPointMake(2*cellSize, 5*cellSize)];
    [self.cellPaths[65] addLineToPoint:CGPointMake(2*cellSize, 6*cellSize)];
    [self.cellPaths[65] addLineToPoint:CGPointMake(3*cellSize, 6*cellSize)];
    [self.cellPaths[65] closePath];
    
    [self.cellPaths[66] moveToPoint:CGPointMake(2*cellSize, 5*cellSize)];
    [self.cellPaths[66] addLineToPoint:CGPointMake(3*cellSize, 5*cellSize)];
    [self.cellPaths[66] addLineToPoint:CGPointMake(3*cellSize, 6*cellSize)];
    [self.cellPaths[66] closePath];
    
    [self.cellPaths[67] moveToPoint:CGPointMake(3*cellSize, 6*cellSize)];
    [self.cellPaths[67] addLineToPoint:CGPointMake(3*cellSize, 5*cellSize)];
    [self.cellPaths[67] addLineToPoint:CGPointMake(4*cellSize, 5*cellSize)];
    [self.cellPaths[67] closePath];
    
    [self.cellPaths[68] moveToPoint:CGPointMake(3*cellSize, 6*cellSize)];
    [self.cellPaths[68] addLineToPoint:CGPointMake(4*cellSize, 6*cellSize)];
    [self.cellPaths[68] addLineToPoint:CGPointMake(4*cellSize, 5*cellSize)];
    [self.cellPaths[68] closePath];
    
    [self.cellPaths[69] moveToPoint:CGPointMake(4*cellSize, 5*cellSize)];
    [self.cellPaths[69] addLineToPoint:CGPointMake(4*cellSize, 6*cellSize)];
    [self.cellPaths[69] addLineToPoint:CGPointMake(5*cellSize, 6*cellSize)];
    [self.cellPaths[69] closePath];
    
    [self.cellPaths[70] moveToPoint:CGPointMake(4*cellSize, 5*cellSize)];
    [self.cellPaths[70] addLineToPoint:CGPointMake(5*cellSize, 5*cellSize)];
    [self.cellPaths[70] addLineToPoint:CGPointMake(5*cellSize, 6*cellSize)];
    [self.cellPaths[70] closePath];
    
    [self.cellPaths[71] moveToPoint:CGPointMake(5*cellSize, 6*cellSize)];
    [self.cellPaths[71] addLineToPoint:CGPointMake(5*cellSize, 5*cellSize)];
    [self.cellPaths[71] addLineToPoint:CGPointMake(6*cellSize, 5*cellSize)];
    [self.cellPaths[71] closePath];
    
    [self.cellPaths[72] moveToPoint:CGPointMake(5*cellSize, 6*cellSize)];
    [self.cellPaths[72] addLineToPoint:CGPointMake(6*cellSize, 6*cellSize)];
    [self.cellPaths[72] addLineToPoint:CGPointMake(6*cellSize, 5*cellSize)];
    [self.cellPaths[72] closePath];
    
    [self.cellPaths[73] moveToPoint:CGPointMake(6*cellSize, 5*cellSize)];
    [self.cellPaths[73] addLineToPoint:CGPointMake(6*cellSize, 6*cellSize)];
    [self.cellPaths[73] addLineToPoint:CGPointMake(7*cellSize, 6*cellSize)];
    [self.cellPaths[73] closePath];
    
    [self.cellPaths[74] moveToPoint:CGPointMake(6*cellSize, 5*cellSize)];
    [self.cellPaths[74] addLineToPoint:CGPointMake(7*cellSize, 5*cellSize)];
    [self.cellPaths[74] addLineToPoint:CGPointMake(7*cellSize, 6*cellSize)];
    [self.cellPaths[74] closePath];
    
    [self.cellPaths[75] moveToPoint:CGPointMake(7*cellSize, 6*cellSize)];
    [self.cellPaths[75] addLineToPoint:CGPointMake(7*cellSize, 5*cellSize)];
    [self.cellPaths[75] addLineToPoint:CGPointMake(8*cellSize, 5*cellSize)];
    [self.cellPaths[75] closePath];
    
    [self.cellPaths[76] moveToPoint:CGPointMake(cellSize, 6*cellSize)];
    [self.cellPaths[76] addLineToPoint:CGPointMake(2*cellSize, 6*cellSize)];
    [self.cellPaths[76] addLineToPoint:CGPointMake(2*cellSize, 7*cellSize)];
    [self.cellPaths[76] closePath];
    
    [self.cellPaths[77] moveToPoint:CGPointMake(2*cellSize, 7*cellSize)];
    [self.cellPaths[77] addLineToPoint:CGPointMake(2*cellSize, 6*cellSize)];
    [self.cellPaths[77] addLineToPoint:CGPointMake(3*cellSize, 6*cellSize)];
    [self.cellPaths[77] closePath];
    
    [self.cellPaths[78] moveToPoint:CGPointMake(2*cellSize, 7*cellSize)];
    [self.cellPaths[78] addLineToPoint:CGPointMake(3*cellSize, 7*cellSize)];
    [self.cellPaths[78] addLineToPoint:CGPointMake(3*cellSize, 6*cellSize)];
    [self.cellPaths[78] closePath];
    
    [self.cellPaths[79] moveToPoint:CGPointMake(3*cellSize, 6*cellSize)];
    [self.cellPaths[79] addLineToPoint:CGPointMake(3*cellSize, 7*cellSize)];
    [self.cellPaths[79] addLineToPoint:CGPointMake(4*cellSize, 7*cellSize)];
    [self.cellPaths[79] closePath];
    
    [self.cellPaths[80] moveToPoint:CGPointMake(3*cellSize, 6*cellSize)];
    [self.cellPaths[80] addLineToPoint:CGPointMake(4*cellSize, 6*cellSize)];
    [self.cellPaths[80] addLineToPoint:CGPointMake(4*cellSize, 7*cellSize)];
    [self.cellPaths[80] closePath];
    
    [self.cellPaths[81] moveToPoint:CGPointMake(4*cellSize, 7*cellSize)];
    [self.cellPaths[81] addLineToPoint:CGPointMake(4*cellSize, 6*cellSize)];
    [self.cellPaths[81] addLineToPoint:CGPointMake(5*cellSize, 6*cellSize)];
    [self.cellPaths[81] closePath];
    
    [self.cellPaths[82] moveToPoint:CGPointMake(4*cellSize, 7*cellSize)];
    [self.cellPaths[82] addLineToPoint:CGPointMake(5*cellSize, 7*cellSize)];
    [self.cellPaths[82] addLineToPoint:CGPointMake(5*cellSize, 6*cellSize)];
    [self.cellPaths[82] closePath];
    
    [self.cellPaths[83] moveToPoint:CGPointMake(5*cellSize, 6*cellSize)];
    [self.cellPaths[83] addLineToPoint:CGPointMake(5*cellSize, 7*cellSize)];
    [self.cellPaths[83] addLineToPoint:CGPointMake(6*cellSize, 7*cellSize)];
    [self.cellPaths[83] closePath];
    
    [self.cellPaths[84] moveToPoint:CGPointMake(5*cellSize, 6*cellSize)];
    [self.cellPaths[84] addLineToPoint:CGPointMake(6*cellSize, 6*cellSize)];
    [self.cellPaths[84] addLineToPoint:CGPointMake(6*cellSize, 7*cellSize)];
    [self.cellPaths[84] closePath];
    
    [self.cellPaths[85] moveToPoint:CGPointMake(6*cellSize, 7*cellSize)];
    [self.cellPaths[85] addLineToPoint:CGPointMake(6*cellSize, 6*cellSize)];
    [self.cellPaths[85] addLineToPoint:CGPointMake(7*cellSize, 6*cellSize)];
    [self.cellPaths[85] closePath];
    
    [self.cellPaths[86] moveToPoint:CGPointMake(2*cellSize, 7*cellSize)];
    [self.cellPaths[86] addLineToPoint:CGPointMake(3*cellSize, 7*cellSize)];
    [self.cellPaths[86] addLineToPoint:CGPointMake(3*cellSize, 8*cellSize)];
    [self.cellPaths[86] closePath];
    
    [self.cellPaths[87] moveToPoint:CGPointMake(3*cellSize, 8*cellSize)];
    [self.cellPaths[87] addLineToPoint:CGPointMake(3*cellSize, 7*cellSize)];
    [self.cellPaths[87] addLineToPoint:CGPointMake(4*cellSize, 7*cellSize)];
    [self.cellPaths[87] closePath];
    
    [self.cellPaths[88] moveToPoint:CGPointMake(3*cellSize, 8*cellSize)];
    [self.cellPaths[88] addLineToPoint:CGPointMake(4*cellSize, 8*cellSize)];
    [self.cellPaths[88] addLineToPoint:CGPointMake(4*cellSize, 7*cellSize)];
    [self.cellPaths[88] closePath];
    
    [self.cellPaths[89] moveToPoint:CGPointMake(4*cellSize, 7*cellSize)];
    [self.cellPaths[89] addLineToPoint:CGPointMake(4*cellSize, 8*cellSize)];
    [self.cellPaths[89] addLineToPoint:CGPointMake(5*cellSize, 8*cellSize)];
    [self.cellPaths[89] closePath];
    
    [self.cellPaths[90] moveToPoint:CGPointMake(4*cellSize, 7*cellSize)];
    [self.cellPaths[90] addLineToPoint:CGPointMake(5*cellSize, 7*cellSize)];
    [self.cellPaths[90] addLineToPoint:CGPointMake(5*cellSize, 8*cellSize)];
    [self.cellPaths[90] closePath];
    
    [self.cellPaths[91] moveToPoint:CGPointMake(5*cellSize, 8*cellSize)];
    [self.cellPaths[91] addLineToPoint:CGPointMake(5*cellSize, 7*cellSize)];
    [self.cellPaths[91] addLineToPoint:CGPointMake(6*cellSize, 7*cellSize)];
    [self.cellPaths[91] closePath];

    
#pragma mark Cell fill and stroking
    
    /* Draw cell highlighting if selected for input - clear highlighting otherwise */
    /* Also set fill color based on whether cell is part of a solved diamond or square */
    
    for (NSUInteger n=0; n<=91; n++) {
        
        /* First turn on or off the cell selection highlighting */
        if (self.cellIndexSelected==n) {
            [cellSelectedColor setStroke];
            [self.cellPaths[n] setLineWidth:cellSelectedLineWidth];
        } else {
            [[UIColor clearColor]setStroke];
            [self.cellPaths[n] setLineWidth:1.0];
        }
        
        [self.cellPaths[n] stroke];
        
        /* Change the cell fill color based on whether cell is marked as solved - only if Use Solution Guide setting is turned on */
        
        if ([self.puzzle.cells[n] isSolved]) {
            if (self.useSolutionGuide) { [cellSolvedFillColor setFill]; }
            else { [cellFillColor setFill]; }
        }
        else {
            [cellFillColor setFill];
        }
        
        /* Use fillWithBlendMode to make sure fill is behind stroked border when highlighted */
        [self.cellPaths[n] fillWithBlendMode:kCGBlendModeOverlay alpha:1.0];
        
    }
        
#pragma mark Draw solid lines for Squares
    
    /* Draw the solid lines for the Squares containing 8 triangular cells */
    /* Each square path labeled with the corresponding number of the square */
    
    UIBezierPath *squarePath0 = [[UIBezierPath alloc]init];
    [squarePath0 moveToPoint:CGPointMake(3*cellSize, 0)];
    [squarePath0 addLineToPoint:CGPointMake(3*cellSize, 2*cellSize)];
    [squarePath0 addLineToPoint:CGPointMake(5*cellSize, 2*cellSize)];
    [squarePath0 addLineToPoint:CGPointMake(5*cellSize, 0)];
    [squarePath0 closePath];
    
    [squarePath0 setLineWidth:squareLineWidth];
    [cellLineColor setStroke];
    [squarePath0 stroke];
    
    UIBezierPath *squarePath1 = [[UIBezierPath alloc]init];
    [squarePath1 moveToPoint:CGPointMake(2*cellSize, cellSize)];
    [squarePath1 addLineToPoint:CGPointMake(2*cellSize, 3*cellSize)];
    [squarePath1 addLineToPoint:CGPointMake(4*cellSize, 3*cellSize)];
    [squarePath1 addLineToPoint:CGPointMake(4*cellSize, cellSize)];
    [squarePath1 closePath];
    
    [squarePath1 setLineWidth:squareLineWidth];
    [cellLineColor setStroke];
    [squarePath1 stroke];
    
    UIBezierPath *squarePath2 = [[UIBezierPath alloc]init];
    [squarePath2 moveToPoint:CGPointMake(4*cellSize, cellSize)];
    [squarePath2 addLineToPoint:CGPointMake(4*cellSize, 3*cellSize)];
    [squarePath2 addLineToPoint:CGPointMake(6*cellSize, 3*cellSize)];
    [squarePath2 addLineToPoint:CGPointMake(6*cellSize, cellSize)];
    [squarePath2 closePath];
    
    [squarePath2 setLineWidth:squareLineWidth];
    [cellLineColor setStroke];
    [squarePath2 stroke];
    
    UIBezierPath *squarePath3 = [[UIBezierPath alloc]init];
    [squarePath3 moveToPoint:CGPointMake(cellSize, 2*cellSize)];
    [squarePath3 addLineToPoint:CGPointMake(cellSize, 4*cellSize)];
    [squarePath3 addLineToPoint:CGPointMake(3*cellSize, 4*cellSize)];
    [squarePath3 addLineToPoint:CGPointMake(3*cellSize, 2*cellSize)];
    [squarePath3 closePath];
    
    [squarePath3 setLineWidth:squareLineWidth];
    [cellLineColor setStroke];
    [squarePath3 stroke];
    
    UIBezierPath *squarePath4 = [[UIBezierPath alloc]init];
    [squarePath4 moveToPoint:CGPointMake(3*cellSize, 2*cellSize)];
    [squarePath4 addLineToPoint:CGPointMake(3*cellSize, 4*cellSize)];
    [squarePath4 addLineToPoint:CGPointMake(5*cellSize, 4*cellSize)];
    [squarePath4 addLineToPoint:CGPointMake(5*cellSize, 2*cellSize)];
    [squarePath4 closePath];
    
    [squarePath4 setLineWidth:squareLineWidth];
    [cellLineColor setStroke];
    [squarePath4 stroke];
    
    UIBezierPath *squarePath5 = [[UIBezierPath alloc]init];
    [squarePath5 moveToPoint:CGPointMake(5*cellSize, 2*cellSize)];
    [squarePath5 addLineToPoint:CGPointMake(5*cellSize, 4*cellSize)];
    [squarePath5 addLineToPoint:CGPointMake(7*cellSize, 4*cellSize)];
    [squarePath5 addLineToPoint:CGPointMake(7*cellSize, 2*cellSize)];
    [squarePath5 closePath];
    
    [squarePath5 setLineWidth:squareLineWidth];
    [cellLineColor setStroke];
    [squarePath5 stroke];
    
    UIBezierPath *squarePath6 = [[UIBezierPath alloc]init];
    [squarePath6 moveToPoint:CGPointMake(0, 3*cellSize)];
    [squarePath6 addLineToPoint:CGPointMake(0, 5*cellSize)];
    [squarePath6 addLineToPoint:CGPointMake(2*cellSize, 5*cellSize)];
    [squarePath6 addLineToPoint:CGPointMake(2*cellSize, 3*cellSize)];
    [squarePath6 closePath];
    
    [squarePath6 setLineWidth:squareLineWidth];
    [cellLineColor setStroke];
    [squarePath6 stroke];
    
    UIBezierPath *squarePath7 = [[UIBezierPath alloc]init];
    [squarePath7 moveToPoint:CGPointMake(2*cellSize, 3*cellSize)];
    [squarePath7 addLineToPoint:CGPointMake(2*cellSize, 5*cellSize)];
    [squarePath7 addLineToPoint:CGPointMake(4*cellSize, 5*cellSize)];
    [squarePath7 addLineToPoint:CGPointMake(4*cellSize, 3*cellSize)];
    [squarePath7 closePath];
    
    [squarePath7 setLineWidth:squareLineWidth];
    [cellLineColor setStroke];
    [squarePath7 stroke];
    
    UIBezierPath *squarePath8 = [[UIBezierPath alloc]init];
    [squarePath8 moveToPoint:CGPointMake(4*cellSize, 3*cellSize)];
    [squarePath8 addLineToPoint:CGPointMake(4*cellSize, 5*cellSize)];
    [squarePath8 addLineToPoint:CGPointMake(6*cellSize, 5*cellSize)];
    [squarePath8 addLineToPoint:CGPointMake(6*cellSize, 3*cellSize)];
    [squarePath8 closePath];
    
    [squarePath8 setLineWidth:squareLineWidth];
    [cellLineColor setStroke];
    [squarePath8 stroke];
    
    UIBezierPath *squarePath9 = [[UIBezierPath alloc]init];
    [squarePath9 moveToPoint:CGPointMake(6*cellSize, 3*cellSize)];
    [squarePath9 addLineToPoint:CGPointMake(6*cellSize, 5*cellSize)];
    [squarePath9 addLineToPoint:CGPointMake(8*cellSize, 5*cellSize)];
    [squarePath9 addLineToPoint:CGPointMake(8*cellSize, 3*cellSize)];
    [squarePath9 closePath];
    
    [squarePath9 setLineWidth:squareLineWidth];
    [cellLineColor setStroke];
    [squarePath9 stroke];
    
    UIBezierPath *squarePath10 = [[UIBezierPath alloc]init];
    [squarePath10 moveToPoint:CGPointMake(cellSize, 4*cellSize)];
    [squarePath10 addLineToPoint:CGPointMake(cellSize, 6*cellSize)];
    [squarePath10 addLineToPoint:CGPointMake(3*cellSize, 6*cellSize)];
    [squarePath10 addLineToPoint:CGPointMake(3*cellSize, 4*cellSize)];
    [squarePath10 closePath];
    
    [squarePath10 setLineWidth:squareLineWidth];
    [cellLineColor setStroke];
    [squarePath10 stroke];
    
    UIBezierPath *squarePath11 = [[UIBezierPath alloc]init];
    [squarePath11 moveToPoint:CGPointMake(3*cellSize, 4*cellSize)];
    [squarePath11 addLineToPoint:CGPointMake(3*cellSize, 6*cellSize)];
    [squarePath11 addLineToPoint:CGPointMake(5*cellSize, 6*cellSize)];
    [squarePath11 addLineToPoint:CGPointMake(5*cellSize, 4*cellSize)];
    [squarePath11 closePath];
    
    [squarePath11 setLineWidth:squareLineWidth];
    [cellLineColor setStroke];
    [squarePath11 stroke];
    
    UIBezierPath *squarePath12 = [[UIBezierPath alloc]init];
    [squarePath12 moveToPoint:CGPointMake(5*cellSize, 4*cellSize)];
    [squarePath12 addLineToPoint:CGPointMake(5*cellSize, 6*cellSize)];
    [squarePath12 addLineToPoint:CGPointMake(7*cellSize, 6*cellSize)];
    [squarePath12 addLineToPoint:CGPointMake(7*cellSize, 4*cellSize)];
    [squarePath12 closePath];
    
    [squarePath12 setLineWidth:squareLineWidth];
    [cellLineColor setStroke];
    [squarePath12 stroke];
    
    UIBezierPath *squarePath13 = [[UIBezierPath alloc]init];
    [squarePath13 moveToPoint:CGPointMake(2*cellSize, 5*cellSize)];
    [squarePath13 addLineToPoint:CGPointMake(2*cellSize, 7*cellSize)];
    [squarePath13 addLineToPoint:CGPointMake(4*cellSize, 7*cellSize)];
    [squarePath13 addLineToPoint:CGPointMake(4*cellSize, 5*cellSize)];
    [squarePath13 closePath];
    
    [squarePath13 setLineWidth:squareLineWidth];
    [cellLineColor setStroke];
    [squarePath13 stroke];
    
    UIBezierPath *squarePath14 = [[UIBezierPath alloc]init];
    [squarePath14 moveToPoint:CGPointMake(4*cellSize, 5*cellSize)];
    [squarePath14 addLineToPoint:CGPointMake(4*cellSize, 7*cellSize)];
    [squarePath14 addLineToPoint:CGPointMake(6*cellSize, 7*cellSize)];
    [squarePath14 addLineToPoint:CGPointMake(6*cellSize, 5*cellSize)];
    [squarePath14 closePath];
    
    [squarePath14 setLineWidth:squareLineWidth];
    [cellLineColor setStroke];
    [squarePath14 stroke];
    
    UIBezierPath *squarePath15 = [[UIBezierPath alloc]init];
    [squarePath15 moveToPoint:CGPointMake(3*cellSize, 6*cellSize)];
    [squarePath15 addLineToPoint:CGPointMake(3*cellSize, 8*cellSize)];
    [squarePath15 addLineToPoint:CGPointMake(5*cellSize, 8*cellSize)];
    [squarePath15 addLineToPoint:CGPointMake(5*cellSize, 6*cellSize)];
    [squarePath15 closePath];
    
    [squarePath15 setLineWidth:squareLineWidth];
    [cellLineColor setStroke];
    [squarePath15 stroke];
    
    /* 4 short line segments to complete cell boundaries at top, bottom, and sides of puzzle */
    
    UIBezierPath *squarePathA = [[UIBezierPath alloc]init];
    [squarePathA moveToPoint:CGPointMake(4*cellSize, 0)];
    [squarePathA addLineToPoint:CGPointMake(4*cellSize, cellSize)];
    
    [squarePathA setLineWidth:squareLineWidth];
    [cellLineColor setStroke];
    [squarePathA stroke];
    
    UIBezierPath *squarePathB = [[UIBezierPath alloc]init];
    [squarePathB moveToPoint:CGPointMake(0, 4*cellSize)];
    [squarePathB addLineToPoint:CGPointMake(cellSize, 4*cellSize)];
    
    [squarePathB setLineWidth:squareLineWidth];
    [cellLineColor setStroke];
    [squarePathB stroke];
    
    UIBezierPath *squarePathC = [[UIBezierPath alloc]init];
    [squarePathC moveToPoint:CGPointMake(4*cellSize, 8*cellSize)];
    [squarePathC addLineToPoint:CGPointMake(4*cellSize, 7*cellSize)];
    
    [squarePathC setLineWidth:squareLineWidth];
    [cellLineColor setStroke];
    [squarePathC stroke];
    
    UIBezierPath *squarePathD = [[UIBezierPath alloc]init];
    [squarePathD moveToPoint:CGPointMake(8*cellSize, 4*cellSize)];
    [squarePathD addLineToPoint:CGPointMake(7*cellSize, 4*cellSize)];
    
    [squarePathD setLineWidth:squareLineWidth];
    [cellLineColor setStroke];
    [squarePathD stroke];
    
    
    
#pragma mark Draw diamonds
    
    /* Draw the dashed diagonal lines defining the diamonds */
    
    UIBezierPath *diamondPath0 = [[UIBezierPath alloc]init];
    [diamondPath0 moveToPoint:CGPointMake(3*cellSize, 0)];
    [diamondPath0 addLineToPoint:CGPointMake(0, 3*cellSize)];
    [diamondPath0 setLineWidth:diamondLineWidth];
    [cellLineColor setStroke];
    [diamondPath0 setLineDash:dashes count:2 phase:0];
    [diamondPath0 stroke];
    
    UIBezierPath *diamondPath1 = [[UIBezierPath alloc]init];
    [diamondPath1 moveToPoint:CGPointMake(5*cellSize, 0)];
    [diamondPath1 addLineToPoint:CGPointMake(0, 5*cellSize)];
    [diamondPath1 setLineWidth:diamondLineWidth];
    [cellLineColor setStroke];
    [diamondPath1 setLineDash:dashes count:2 phase:0];
    [diamondPath1 stroke];
    
    UIBezierPath *diamondPath2 = [[UIBezierPath alloc]init];
    [diamondPath2 moveToPoint:CGPointMake(6*cellSize, cellSize)];
    [diamondPath2 addLineToPoint:CGPointMake(cellSize, 6*cellSize)];
    [diamondPath2 setLineWidth:diamondLineWidth];
    [cellLineColor setStroke];
    [diamondPath2 setLineDash:dashes count:2 phase:0];
    [diamondPath2 stroke];
    
    UIBezierPath *diamondPath3 = [[UIBezierPath alloc]init];
    [diamondPath3 moveToPoint:CGPointMake(7*cellSize, 2*cellSize)];
    [diamondPath3 addLineToPoint:CGPointMake(2*cellSize, 7*cellSize)];
    [diamondPath3 setLineWidth:diamondLineWidth];
    [cellLineColor setStroke];
    [diamondPath3 setLineDash:dashes count:2 phase:0];
    [diamondPath3 stroke];
    
    UIBezierPath *diamondPath4 = [[UIBezierPath alloc]init];
    [diamondPath4 moveToPoint:CGPointMake(8*cellSize, 3*cellSize)];
    [diamondPath4 addLineToPoint:CGPointMake(3*cellSize, 8*cellSize)];
    [diamondPath4 setLineWidth:diamondLineWidth];
    [cellLineColor setStroke];
    [diamondPath4 setLineDash:dashes count:2 phase:0];
    [diamondPath4 stroke];
    
    UIBezierPath *diamondPath5 = [[UIBezierPath alloc]init];
    [diamondPath5 moveToPoint:CGPointMake(8*cellSize, 5*cellSize)];
    [diamondPath5 addLineToPoint:CGPointMake(5*cellSize, 8*cellSize)];
    [diamondPath5 setLineWidth:diamondLineWidth];
    [cellLineColor setStroke];
    [diamondPath5 setLineDash:dashes count:2 phase:0];
    [diamondPath5 stroke];

    UIBezierPath *diamondPath6 = [[UIBezierPath alloc]init];
    [diamondPath6 moveToPoint:CGPointMake(5*cellSize, 0)];
    [diamondPath6 addLineToPoint:CGPointMake(8*cellSize, 3*cellSize)];
    [diamondPath6 setLineWidth:diamondLineWidth];
    [cellLineColor setStroke];
    [diamondPath6 setLineDash:dashes count:2 phase:0];
    [diamondPath6 stroke];
    
    UIBezierPath *diamondPath7 = [[UIBezierPath alloc]init];
    [diamondPath7 moveToPoint:CGPointMake(3*cellSize, 0)];
    [diamondPath7 addLineToPoint:CGPointMake(8*cellSize, 5*cellSize)];
    [diamondPath7 setLineWidth:diamondLineWidth];
    [cellLineColor setStroke];
    [diamondPath7 setLineDash:dashes count:2 phase:0];
    [diamondPath7 stroke];
    
    UIBezierPath *diamondPath8 = [[UIBezierPath alloc]init];
    [diamondPath8 moveToPoint:CGPointMake(2*cellSize, cellSize)];
    [diamondPath8 addLineToPoint:CGPointMake(7*cellSize, 6*cellSize)];
    [diamondPath8 setLineWidth:diamondLineWidth];
    [cellLineColor setStroke];
    [diamondPath8 setLineDash:dashes count:2 phase:0];
    [diamondPath8 stroke];
    
    UIBezierPath *diamondPath9 = [[UIBezierPath alloc]init];
    [diamondPath9 moveToPoint:CGPointMake(cellSize, 2*cellSize)];
    [diamondPath9 addLineToPoint:CGPointMake(6*cellSize, 7*cellSize)];
    [diamondPath9 setLineWidth:diamondLineWidth];
    [cellLineColor setStroke];
    [diamondPath9 setLineDash:dashes count:2 phase:0];
    [diamondPath9 stroke];
    
    UIBezierPath *diamondPath10 = [[UIBezierPath alloc]init];
    [diamondPath10 moveToPoint:CGPointMake(0, 3*cellSize)];
    [diamondPath10 addLineToPoint:CGPointMake(5*cellSize, 8*cellSize)];
    [diamondPath10 setLineWidth:diamondLineWidth];
    [cellLineColor setStroke];
    [diamondPath10 setLineDash:dashes count:2 phase:0];
    [diamondPath10 stroke];
    
    UIBezierPath *diamondPath11 = [[UIBezierPath alloc]init];
    [diamondPath11 moveToPoint:CGPointMake(0, 5*cellSize)];
    [diamondPath11 addLineToPoint:CGPointMake(3*cellSize, 8*cellSize)];
    [diamondPath11 setLineWidth:diamondLineWidth];
    [cellLineColor setStroke];
    [diamondPath11 setLineDash:dashes count:2 phase:0];
    [diamondPath11 stroke];
    
#pragma mark Draw filled boxes at intersections of diamonds
    
    UIColor *boxSolvedColor;
    if (self.useSolutionGuide) { boxSolvedColor = squareSolvedColor; }
    else { boxSolvedColor = cellLineColor; }
    
    UIBezierPath *box0 = [UIBezierPath bezierPathWithRect:CGRectMake(4*cellSize-boxSize/2, cellSize-boxSize/2, boxSize, boxSize)];
    if ([self.puzzle.squares[0] isSolved]) { [boxSolvedColor setFill]; } else { [cellLineColor setFill]; }
    [cellLineColor setStroke];
    [box0 fill];
    [box0 stroke];
    
    UIBezierPath *box1 = [UIBezierPath bezierPathWithRect:CGRectMake(3*cellSize-boxSize/2, 2*cellSize-boxSize/2, boxSize, boxSize)];
    if ([self.puzzle.squares[1] isSolved]) { [boxSolvedColor setFill]; } else { [cellLineColor setFill]; }
    [cellLineColor setStroke];
    [box1 fill];
    [box1 stroke];
    
    UIBezierPath *box2 = [UIBezierPath bezierPathWithRect:CGRectMake(5*cellSize-boxSize/2, 2*cellSize-boxSize/2, boxSize, boxSize)];
    if ([self.puzzle.squares[2] isSolved]) { [boxSolvedColor setFill]; } else { [cellLineColor setFill]; }
    [cellLineColor setStroke];
    [box2 fill];
    [box2 stroke];
    
    UIBezierPath *box3 = [UIBezierPath bezierPathWithRect:CGRectMake(2*cellSize-boxSize/2, 3*cellSize-boxSize/2, boxSize, boxSize)];
    if ([self.puzzle.squares[3] isSolved]) { [boxSolvedColor setFill]; } else { [cellLineColor setFill]; }
    [cellLineColor setStroke];
    [box3 fill];
    [box3 stroke];
    
    UIBezierPath *box4 = [UIBezierPath bezierPathWithRect:CGRectMake(4*cellSize-boxSize/2, 3*cellSize-boxSize/2, boxSize, boxSize)];
    if ([self.puzzle.squares[4] isSolved]) { [boxSolvedColor setFill]; } else { [cellLineColor setFill]; }
    [cellLineColor setStroke];
    [box4 fill];
    [box4 stroke];
    
    UIBezierPath *box5 = [UIBezierPath bezierPathWithRect:CGRectMake(6*cellSize-boxSize/2, 3*cellSize-boxSize/2, boxSize, boxSize)];
    if ([self.puzzle.squares[5] isSolved]) { [boxSolvedColor setFill]; } else { [cellLineColor setFill]; }
    [cellLineColor setStroke];
    [box5 fill];
    [box5 stroke];
    
    UIBezierPath *box6 = [UIBezierPath bezierPathWithRect:CGRectMake(cellSize-boxSize/2, 4*cellSize-boxSize/2, boxSize, boxSize)];
    if ([self.puzzle.squares[6] isSolved]) { [boxSolvedColor setFill]; } else { [cellLineColor setFill]; }
    [cellLineColor setStroke];
    [box6 fill];
    [box6 stroke];
    
    UIBezierPath *box7 = [UIBezierPath bezierPathWithRect:CGRectMake(3*cellSize-boxSize/2, 4*cellSize-boxSize/2, boxSize, boxSize)];
    if ([self.puzzle.squares[7] isSolved]) { [boxSolvedColor setFill]; } else { [cellLineColor setFill]; }
    [cellLineColor setStroke];
    [box7 fill];
    [box7 stroke];
    
    UIBezierPath *box8 = [UIBezierPath bezierPathWithRect:CGRectMake(5*cellSize-boxSize/2, 4*cellSize-boxSize/2, boxSize, boxSize)];
    if ([self.puzzle.squares[8] isSolved]) { [boxSolvedColor setFill]; } else { [cellLineColor setFill]; }
    [cellLineColor setStroke];
    [box8 fill];
    [box8 stroke];
    
    UIBezierPath *box9 = [UIBezierPath bezierPathWithRect:CGRectMake(7*cellSize-boxSize/2, 4*cellSize-boxSize/2, boxSize, boxSize)];
    if ([self.puzzle.squares[9] isSolved]) { [boxSolvedColor setFill]; } else { [cellLineColor setFill]; }
    [cellLineColor setStroke];
    [box9 fill];
    [box9 stroke];
    
    UIBezierPath *box10 = [UIBezierPath bezierPathWithRect:CGRectMake(2*cellSize-boxSize/2, 5*cellSize-boxSize/2, boxSize, boxSize)];
    if ([self.puzzle.squares[10] isSolved]) { [boxSolvedColor setFill]; } else { [cellLineColor setFill]; }
    [cellLineColor setStroke];
    [box10 fill];
    [box10 stroke];
    
    UIBezierPath *box11 = [UIBezierPath bezierPathWithRect:CGRectMake(4*cellSize-boxSize/2, 5*cellSize-boxSize/2, boxSize, boxSize)];
    if ([self.puzzle.squares[11] isSolved]) { [boxSolvedColor setFill]; } else { [cellLineColor setFill]; }
    [cellLineColor setStroke];
    [box11 fill];
    [box11 stroke];
    
    UIBezierPath *box12 = [UIBezierPath bezierPathWithRect:CGRectMake(6*cellSize-boxSize/2, 5*cellSize-boxSize/2, boxSize, boxSize)];
    if ([self.puzzle.squares[12] isSolved]) { [boxSolvedColor setFill]; } else { [cellLineColor setFill]; }
    [cellLineColor setStroke];
    [box12 fill];
    [box12 stroke];
    
    UIBezierPath *box13 = [UIBezierPath bezierPathWithRect:CGRectMake(3*cellSize-boxSize/2, 6*cellSize-boxSize/2, boxSize, boxSize)];
    if ([self.puzzle.squares[13] isSolved]) { [boxSolvedColor setFill]; } else { [cellLineColor setFill]; }
    [cellLineColor setStroke];
    [box13 fill];
    [box13 stroke];
    
    UIBezierPath *box14 = [UIBezierPath bezierPathWithRect:CGRectMake(5*cellSize-boxSize/2, 6*cellSize-boxSize/2, boxSize, boxSize)];
    if ([self.puzzle.squares[14] isSolved]) { [boxSolvedColor setFill]; } else { [cellLineColor setFill]; }
    [cellLineColor setStroke];
    [box14 fill];
    [box14 stroke];
    
    UIBezierPath *box15 = [UIBezierPath bezierPathWithRect:CGRectMake(4*cellSize-boxSize/2, 7*cellSize-boxSize/2, boxSize, boxSize)];
    if ([self.puzzle.squares[15] isSolved]) { [boxSolvedColor setFill]; } else { [cellLineColor setFill]; }
    [cellLineColor setStroke];
    [box15 fill];
    [box15 stroke];
    
#pragma mark Draw labels in cells with cell contents
    
    [self drawCellContents];
    
}


-(void) drawCellContents
{
    /* Set attributes of the attributed text to draw for the cell contents */
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    UIFont *contentsFont = [UIFont fontWithName:CELL_CONTENTS_FONT size:(0.5*cellSize*CELL_CONTENTS_SCALE_FACTOR)]; /* scale the font for best fit in the cell */
    
    // The following block returns the correct font color to use depending on whether the cell contents are marked as locked
    UIColor* (^fontColor) (Cell*) = ^ (Cell* inputCell) {
        if ( [inputCell isLocked] )
        { return lockedCellFontColor; } else
        { return enteredCellFontColor; }
    };
    

    // Draw contents into cells
    
    // First create the attributed text strings for each of the cells and then draw in rect - only draw string if it is not "0"
    
    
    NSMutableAttributedString *contentsText0 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[0] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[0])}];
    if ([self.puzzle.cells[0] cellContents] != 0) {[contentsText0 drawInRect:CGRectMake(2.5*cellSize, 0.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    
    NSMutableAttributedString *contentsText1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[1] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[1])}];
    if ([self.puzzle.cells[1] cellContents] != 0) {[contentsText1 drawInRect:CGRectMake(3*cellSize, 0.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};

    NSMutableAttributedString *contentsText2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[2] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[2])}];
    if ([self.puzzle.cells[2] cellContents] != 0) {[contentsText2 drawInRect:CGRectMake(3.5*cellSize, 0, 0.5*cellSize, 0.5*cellSize)];};

    NSMutableAttributedString *contentsText3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[3] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[3])}];
    if ([self.puzzle.cells[3] cellContents] != 0) {[contentsText3 drawInRect:CGRectMake(4*cellSize, 0, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText4 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[4] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[4])}];
    if ([self.puzzle.cells[4] cellContents] != 0) {[contentsText4 drawInRect:CGRectMake(4.5*cellSize, 0.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText5 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[5] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[5])}];
    if ([self.puzzle.cells[5] cellContents] != 0) {[contentsText5 drawInRect:CGRectMake(5*cellSize, 0.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText6 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[6] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[6])}];
    if ([self.puzzle.cells[6] cellContents] != 0) {[contentsText6 drawInRect:CGRectMake(1.5*cellSize, 1.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText7 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[7] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[7])}];
    if ([self.puzzle.cells[7] cellContents] != 0) {[contentsText7 drawInRect:CGRectMake(2*cellSize, 1.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};

    NSMutableAttributedString *contentsText8 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[8] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[8])}];
    if ([self.puzzle.cells[8] cellContents] != 0) {[contentsText8 drawInRect:CGRectMake(2.5*cellSize, cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText9 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[9] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[9])}];
    if ([self.puzzle.cells[9] cellContents] != 0) {[contentsText9 drawInRect:CGRectMake(3*cellSize, cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText10 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[10] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[10])}];
    if ([self.puzzle.cells[10] cellContents] != 0) {[contentsText10 drawInRect:CGRectMake(3.5*cellSize, 1.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText11 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[11] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[11])}];
    if ([self.puzzle.cells[11] cellContents] != 0) {[contentsText11 drawInRect:CGRectMake(4*cellSize, 1.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText12 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[12] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[12])}];
    if ([self.puzzle.cells[12] cellContents] != 0) {[contentsText12 drawInRect:CGRectMake(4.5*cellSize, cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText13 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[13] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[13])}];
    if ([self.puzzle.cells[13] cellContents] != 0) {[contentsText13 drawInRect:CGRectMake(5*cellSize, cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText14 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[14] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[14])}];
    if ([self.puzzle.cells[14] cellContents] != 0) {[contentsText14 drawInRect:CGRectMake(5.5*cellSize, 1.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText15 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[15] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[15])}];
    if ([self.puzzle.cells[15] cellContents] != 0) {[contentsText15 drawInRect:CGRectMake(6*cellSize, 1.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText16 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[16] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[16])}];
    if ([self.puzzle.cells[16] cellContents] != 0) {[contentsText16 drawInRect:CGRectMake(0.5*cellSize, 2.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText17 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[17] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[17])}];
    if ([self.puzzle.cells[17] cellContents] != 0) {[contentsText17 drawInRect:CGRectMake(cellSize, 2.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText18 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[18] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[18])}];
    if ([self.puzzle.cells[18] cellContents] != 0) {[contentsText18 drawInRect:CGRectMake(1.5*cellSize, 2*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText19 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[19] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[19])}];
    if ([self.puzzle.cells[19] cellContents] != 0) {[contentsText19 drawInRect:CGRectMake(2*cellSize, 2*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText20 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[20] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[20])}];
    if ([self.puzzle.cells[20] cellContents] != 0) {[contentsText20 drawInRect:CGRectMake(2.5*cellSize, 2.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText21 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[21] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[21])}];
    if ([self.puzzle.cells[21] cellContents] != 0) {[contentsText21 drawInRect:CGRectMake(3*cellSize, 2.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText22 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[22] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[22])}];
    if ([self.puzzle.cells[22] cellContents] != 0) {[contentsText22 drawInRect:CGRectMake(3.5*cellSize, 2*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText23 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[23] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[23])}];
    if ([self.puzzle.cells[23] cellContents] != 0) {[contentsText23 drawInRect:CGRectMake(4*cellSize, 2*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText24 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[24] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[24])}];
    if ([self.puzzle.cells[24] cellContents] != 0) {[contentsText24 drawInRect:CGRectMake(4.5*cellSize, 2.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText25 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[25] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[25])}];
    if ([self.puzzle.cells[25] cellContents] != 0) {[contentsText25 drawInRect:CGRectMake(5*cellSize, 2.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText26 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[26] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[26])}];
    if ([self.puzzle.cells[26] cellContents] != 0) {[contentsText26 drawInRect:CGRectMake(5.5*cellSize, 2*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText27 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[27] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[27])}];
    if ([self.puzzle.cells[27] cellContents] != 0) {[contentsText27 drawInRect:CGRectMake(6*cellSize, 2*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText28 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[28] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[28])}];
    if ([self.puzzle.cells[28] cellContents] != 0) {[contentsText28 drawInRect:CGRectMake(6.5*cellSize, 2.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText29 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[29] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[29])}];
    if ([self.puzzle.cells[29] cellContents] != 0) {[contentsText29 drawInRect:CGRectMake(7*cellSize, 2.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText30 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[30] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[30])}];
    if ([self.puzzle.cells[30] cellContents] != 0) {[contentsText30 drawInRect:CGRectMake(0, 3.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText31 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[31] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[31])}];
    if ([self.puzzle.cells[31] cellContents] != 0) {[contentsText31 drawInRect:CGRectMake(0.5*cellSize, 3*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText32 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[32] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[32])}];
    if ([self.puzzle.cells[32] cellContents] != 0) {[contentsText32 drawInRect:CGRectMake(cellSize, 3*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText33 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[33] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[33])}];
    if ([self.puzzle.cells[33] cellContents] != 0) {[contentsText33 drawInRect:CGRectMake(1.5*cellSize, 3.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText34 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[34] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[34])}];
    if ([self.puzzle.cells[34] cellContents] != 0) {[contentsText34 drawInRect:CGRectMake(2*cellSize, 3.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText35 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[35] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[35])}];
    if ([self.puzzle.cells[35] cellContents] != 0) {[contentsText35 drawInRect:CGRectMake(2.5*cellSize, 3*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText36 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[36] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[36])}];
    if ([self.puzzle.cells[36] cellContents] != 0) {[contentsText36 drawInRect:CGRectMake(3*cellSize, 3*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText37 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[37] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[37])}];
    if ([self.puzzle.cells[37] cellContents] != 0) {[contentsText37 drawInRect:CGRectMake(3.5*cellSize, 3.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText38 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[38] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[38])}];
    if ([self.puzzle.cells[38] cellContents] != 0) {[contentsText38 drawInRect:CGRectMake(4*cellSize, 3.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText39 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[39] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[39])}];
    if ([self.puzzle.cells[39] cellContents] != 0) {[contentsText39 drawInRect:CGRectMake(4.5*cellSize, 3*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText40 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[40] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[40])}];
    if ([self.puzzle.cells[40] cellContents] != 0) {[contentsText40 drawInRect:CGRectMake(5*cellSize, 3*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText41 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[41] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[41])}];
    if ([self.puzzle.cells[41] cellContents] != 0) {[contentsText41 drawInRect:CGRectMake(5.5*cellSize, 3.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText42 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[42] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[42])}];
    if ([self.puzzle.cells[42] cellContents] != 0) {[contentsText42 drawInRect:CGRectMake(6*cellSize, 3.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText43 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[43] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[43])}];
    if ([self.puzzle.cells[43] cellContents] != 0) {[contentsText43 drawInRect:CGRectMake(6.5*cellSize, 3*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText44 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[44] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[44])}];
    if ([self.puzzle.cells[44] cellContents] != 0) {[contentsText44 drawInRect:CGRectMake(7*cellSize, 3*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText45 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[45] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[45])}];
    if ([self.puzzle.cells[45] cellContents] != 0) {[contentsText45 drawInRect:CGRectMake(7.5*cellSize, 3.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText46 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[46] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[46])}];
    if ([self.puzzle.cells[46] cellContents] != 0) {[contentsText46 drawInRect:CGRectMake(0, 4*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText47 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[47] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[47])}];
    if ([self.puzzle.cells[47] cellContents] != 0) {[contentsText47 drawInRect:CGRectMake(0.5*cellSize, 4.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText48 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[48] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[48])}];
    if ([self.puzzle.cells[48] cellContents] != 0) {[contentsText48 drawInRect:CGRectMake(cellSize, 4.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText49 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[49] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[49])}];
    if ([self.puzzle.cells[49] cellContents] != 0) {[contentsText49 drawInRect:CGRectMake(1.5*cellSize, 4*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText50 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[50] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[50])}];
    if ([self.puzzle.cells[50] cellContents] != 0) {[contentsText50 drawInRect:CGRectMake(2*cellSize, 4*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText51 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[51] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[51])}];
    if ([self.puzzle.cells[51] cellContents] != 0) {[contentsText51 drawInRect:CGRectMake(2.5*cellSize, 4.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText52 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[52] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[52])}];
    if ([self.puzzle.cells[52] cellContents] != 0) {[contentsText52 drawInRect:CGRectMake(3*cellSize, 4.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText53 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[53] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[53])}];
    if ([self.puzzle.cells[53] cellContents] != 0) {[contentsText53 drawInRect:CGRectMake(3.5*cellSize, 4*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText54 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[54] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[54])}];
    if ([self.puzzle.cells[54] cellContents] != 0) {[contentsText54 drawInRect:CGRectMake(4*cellSize, 4*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText55 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[55] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[55])}];
    if ([self.puzzle.cells[55] cellContents] != 0) {[contentsText55 drawInRect:CGRectMake(4.5*cellSize, 4.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText56 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[56] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[56])}];
    if ([self.puzzle.cells[56] cellContents] != 0) {[contentsText56 drawInRect:CGRectMake(5*cellSize, 4.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText57 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[57] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[57])}];
    if ([self.puzzle.cells[57] cellContents] != 0) {[contentsText57 drawInRect:CGRectMake(5.5*cellSize, 4*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText58 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[58] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[58])}];
    if ([self.puzzle.cells[58] cellContents] != 0) {[contentsText58 drawInRect:CGRectMake(6*cellSize, 4*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText59 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[59] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[59])}];
    if ([self.puzzle.cells[59] cellContents] != 0) {[contentsText59 drawInRect:CGRectMake(6.5*cellSize, 4.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText60 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[60] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[60])}];
    if ([self.puzzle.cells[60] cellContents] != 0) {[contentsText60 drawInRect:CGRectMake(7*cellSize, 4.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText61 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[61] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[61])}];
    if ([self.puzzle.cells[61] cellContents] != 0) {[contentsText61 drawInRect:CGRectMake(7.5*cellSize, 4*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText62 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[62] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[62])}];
    if ([self.puzzle.cells[62] cellContents] != 0) {[contentsText62 drawInRect:CGRectMake(0.5*cellSize, 5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText63 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[63] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[63])}];
    if ([self.puzzle.cells[63] cellContents] != 0) {[contentsText63 drawInRect:CGRectMake(cellSize, 5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText64 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[64] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[64])}];
    if ([self.puzzle.cells[64] cellContents] != 0) {[contentsText64 drawInRect:CGRectMake(1.5*cellSize, 5.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText65 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[65] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[65])}];
    if ([self.puzzle.cells[65] cellContents] != 0) {[contentsText65 drawInRect:CGRectMake(2*cellSize, 5.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText66 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[66] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[66])}];
    if ([self.puzzle.cells[66] cellContents] != 0) {[contentsText66 drawInRect:CGRectMake(2.5*cellSize, 5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText67 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[67] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[67])}];
    if ([self.puzzle.cells[67] cellContents] != 0) {[contentsText67 drawInRect:CGRectMake(3*cellSize, 5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText68 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[68] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[68])}];
    if ([self.puzzle.cells[68] cellContents] != 0) {[contentsText68 drawInRect:CGRectMake(3.5*cellSize, 5.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText69 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[69] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[69])}];
    if ([self.puzzle.cells[69] cellContents] != 0) {[contentsText69 drawInRect:CGRectMake(4*cellSize, 5.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText70 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[70] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[70])}];
    if ([self.puzzle.cells[70] cellContents] != 0) {[contentsText70 drawInRect:CGRectMake(4.5*cellSize, 5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText71 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[71] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[71])}];
    if ([self.puzzle.cells[71] cellContents] != 0) {[contentsText71 drawInRect:CGRectMake(5*cellSize, 5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText72 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[72] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[72])}];
    if ([self.puzzle.cells[72] cellContents] != 0) {[contentsText72 drawInRect:CGRectMake(5.5*cellSize, 5.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText73 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[73] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[73])}];
    if ([self.puzzle.cells[73] cellContents] != 0) {[contentsText73 drawInRect:CGRectMake(6*cellSize, 5.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText74 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[74] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[74])}];
    if ([self.puzzle.cells[74] cellContents] != 0) {[contentsText74 drawInRect:CGRectMake(6.5*cellSize, 5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText75 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[75] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[75])}];
    if ([self.puzzle.cells[75] cellContents] != 0) {[contentsText75 drawInRect:CGRectMake(7*cellSize, 5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText76 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[76] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[76])}];
    if ([self.puzzle.cells[76] cellContents] != 0) {[contentsText76 drawInRect:CGRectMake(1.5*cellSize, 6*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText77 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[77] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[77])}];
    if ([self.puzzle.cells[77] cellContents] != 0) {[contentsText77 drawInRect:CGRectMake(2*cellSize, 6*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText78 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[78] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[78])}];
    if ([self.puzzle.cells[78] cellContents] != 0) {[contentsText78 drawInRect:CGRectMake(2.5*cellSize, 6.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText79 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[79] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[79])}];
    if ([self.puzzle.cells[79] cellContents] != 0) {[contentsText79 drawInRect:CGRectMake(3*cellSize, 6.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText80 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[80] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[80])}];
    if ([self.puzzle.cells[80] cellContents] != 0) {[contentsText80 drawInRect:CGRectMake(3.5*cellSize, 6*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText81 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[81] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[81])}];
    if ([self.puzzle.cells[81] cellContents] != 0) {[contentsText81 drawInRect:CGRectMake(4*cellSize, 6*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText82 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[82] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[82])}];
    if ([self.puzzle.cells[82] cellContents] != 0) {[contentsText82 drawInRect:CGRectMake(4.5*cellSize, 6.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText83 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[83] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[83])}];
    if ([self.puzzle.cells[83] cellContents] != 0) {[contentsText83 drawInRect:CGRectMake(5*cellSize, 6.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText84 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[84] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[84])}];
    if ([self.puzzle.cells[84] cellContents] != 0) {[contentsText84 drawInRect:CGRectMake(5.5*cellSize, 6*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText85 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[85] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[85])}];
    if ([self.puzzle.cells[85] cellContents] != 0) {[contentsText85 drawInRect:CGRectMake(6*cellSize, 6*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText86 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[86] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[86])}];
    if ([self.puzzle.cells[86] cellContents] != 0) {[contentsText86 drawInRect:CGRectMake(2.5*cellSize, 7*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText87 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[87] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[87])}];
    if ([self.puzzle.cells[87] cellContents] != 0) {[contentsText87 drawInRect:CGRectMake(3*cellSize, 7*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText88 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[88] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[88])}];
    if ([self.puzzle.cells[88] cellContents] != 0) {[contentsText88 drawInRect:CGRectMake(3.5*cellSize, 7.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText89 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[89] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[89])}];
    if ([self.puzzle.cells[89] cellContents] != 0) {[contentsText89 drawInRect:CGRectMake(4*cellSize, 7.5*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText90 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[90] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[90])}];
    if ([self.puzzle.cells[90] cellContents] != 0) {[contentsText90 drawInRect:CGRectMake(4.5*cellSize, 7*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
    NSMutableAttributedString *contentsText91 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lu", (unsigned long)[self.puzzle.cells[91] cellContents]] attributes:@{ NSFontAttributeName : contentsFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : fontColor(self.puzzle.cells[91])}];
    if ([self.puzzle.cells[91] cellContents] != 0) {[contentsText91 drawInRect:CGRectMake(5*cellSize, 7*cellSize, 0.5*cellSize, 0.5*cellSize)];};
    
}



/*  Gesture recognition */

-(void)tap:(UITapGestureRecognizer *)gesture
{

 if (gesture.state==UIGestureRecognizerStateEnded) {
        CGPoint touchPoint = [gesture locationInView:self];
     
     for (int n=0; n<=91; n++) {
     
         /* test to see if the path contains the tap location and cell is not locked */
     if ([self.cellPaths[n] containsPoint:touchPoint]) {

         if ([self.puzzle.cells[n] isLocked]) {break;}  /* Ignore the touch in this cell if the cell contents are locked */
         [self setCellIndexSelected:n];
         [self setNeedsDisplay];
            
        }
     }
 }

 
}




@end
