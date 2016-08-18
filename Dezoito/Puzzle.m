//
//  Puzzle.m
//  Dezoito
//
//  Created by Ed Ballington on 6/30/14.
//  Copyright (c) 2014 Ed Ballington. All rights reserved.
//

#import "Puzzle.h"

@implementation Puzzle

Cell *cellElement;
Square *squareElement;
Diamond *diamondElement;

#pragma mark - Initialization

-(instancetype) initPuzzleWithCells:(NSArray *)cellContentsArray;
{
    if (self = [super init]) {

    _cells = [[NSMutableArray alloc] init];
    _solved = false;
        
        for (NSUInteger n=0; n<=91; n++)
        {
            //Create and add a cell object to the cell array
            [self.cells addObject:[[Cell alloc]init]];
            [self.cells[n] setSelected:false];
            [self.cells[n] setSolved:false];
            [self.cells[n] setCellContents:[cellContentsArray[n] intValue]];
            
            if ([cellContentsArray[n] intValue] == 0) { [self.cells[n] setLocked:false]; }  //Blank cell
            else { [self.cells[n] setLocked:true]; }  //Predefined cell

        }
        
    return self;

    } else {return nil;}
}

-(void) initSquaresWithCells;
// Setup each of the squares in the puzzle with the correct cells that belong to it

{
    _squares = [[NSMutableArray alloc]initWithCapacity:16];  //16 squares in the puzzle
    
    self.squares[0] = [[Square alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[1],self.cells[2],self.cells[3],self.cells[4],self.cells[9],self.cells[10],self.cells[11],self.cells[12], nil]];
    self.squares[1] = [[Square alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[7],self.cells[8],self.cells[9],self.cells[10],self.cells[19],self.cells[20],self.cells[21],self.cells[22], nil]];
    self.squares[2] = [[Square alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[11],self.cells[12],self.cells[13],self.cells[14],self.cells[23],self.cells[24],self.cells[25],self.cells[26], nil]];
    self.squares[3] = [[Square alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[17],self.cells[18],self.cells[19],self.cells[20],self.cells[32],self.cells[33],self.cells[34],self.cells[35], nil]];
    self.squares[4] = [[Square alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[21],self.cells[22],self.cells[23],self.cells[24],self.cells[36],self.cells[37],self.cells[38],self.cells[39], nil]];
    self.squares[5] = [[Square alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[25],self.cells[26],self.cells[27],self.cells[28],self.cells[40],self.cells[41],self.cells[42],self.cells[43], nil]];
    self.squares[6] = [[Square alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[30],self.cells[31],self.cells[32],self.cells[33],self.cells[46],self.cells[47],self.cells[48],self.cells[49], nil]];
    self.squares[7] = [[Square alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[34],self.cells[35],self.cells[36],self.cells[37],self.cells[50],self.cells[51],self.cells[52],self.cells[53], nil]];
    self.squares[8] = [[Square alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[38],self.cells[39],self.cells[40],self.cells[41],self.cells[54],self.cells[55],self.cells[56],self.cells[57], nil]];
    self.squares[9] = [[Square alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[42],self.cells[43],self.cells[44],self.cells[45],self.cells[58],self.cells[59],self.cells[60],self.cells[61], nil]];
    self.squares[10] = [[Square alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[48],self.cells[49],self.cells[50],self.cells[51],self.cells[63],self.cells[64],self.cells[65],self.cells[66], nil]];
    self.squares[11] = [[Square alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[52],self.cells[53],self.cells[54],self.cells[55],self.cells[67],self.cells[68],self.cells[69],self.cells[70], nil]];
    self.squares[12] = [[Square alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[56],self.cells[57],self.cells[58],self.cells[59],self.cells[71],self.cells[72],self.cells[73],self.cells[74], nil]];
    self.squares[13] = [[Square alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[65],self.cells[66],self.cells[67],self.cells[68],self.cells[77],self.cells[78],self.cells[79],self.cells[80], nil]];
    self.squares[14] = [[Square alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[69],self.cells[70],self.cells[71],self.cells[72],self.cells[81],self.cells[82],self.cells[83],self.cells[84], nil]];
    self.squares[15] = [[Square alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[79],self.cells[80],self.cells[81],self.cells[82],self.cells[87],self.cells[88],self.cells[89],self.cells[90], nil]];
    
}

-(void) initDiamondsWithCells;
// Setup each of the diamonds in the puzzle with the correct cells that belong to it
{
    _diamonds = [[NSMutableArray alloc]initWithCapacity:23];  //23 diamonds in the puzzle
    
    self.diamonds[0] = [[Diamond alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[88],self.cells[89],self.cells[2],self.cells[3], nil]];
    self.diamonds[1] = [[Diamond alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[0],self.cells[1],self.cells[8],self.cells[9], nil]];
    self.diamonds[2] = [[Diamond alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[4],self.cells[5],self.cells[12],self.cells[13], nil]];
    self.diamonds[3] = [[Diamond alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[6],self.cells[7],self.cells[18],self.cells[19], nil]];
    self.diamonds[4] = [[Diamond alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[10],self.cells[11],self.cells[22],self.cells[23], nil]];
    self.diamonds[5] = [[Diamond alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[14],self.cells[15],self.cells[26],self.cells[27], nil]];
    self.diamonds[6] = [[Diamond alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[16],self.cells[17],self.cells[31],self.cells[32], nil]];
    self.diamonds[7] = [[Diamond alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[20],self.cells[21],self.cells[35],self.cells[36], nil]];
    self.diamonds[8] = [[Diamond alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[24],self.cells[25],self.cells[39],self.cells[40], nil]];
    self.diamonds[9] = [[Diamond alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[28],self.cells[29],self.cells[43],self.cells[44], nil]];
    self.diamonds[10] = [[Diamond alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[30],self.cells[45],self.cells[46],self.cells[61], nil]];
    self.diamonds[11] = [[Diamond alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[33],self.cells[34],self.cells[49],self.cells[50], nil]];
    self.diamonds[12] = [[Diamond alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[37],self.cells[38],self.cells[53],self.cells[54], nil]];
    self.diamonds[13] = [[Diamond alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[41],self.cells[42],self.cells[57],self.cells[58], nil]];
    self.diamonds[14] = [[Diamond alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[47],self.cells[48],self.cells[62],self.cells[63], nil]];
    self.diamonds[15] = [[Diamond alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[51],self.cells[52],self.cells[66],self.cells[67], nil]];
    self.diamonds[16] = [[Diamond alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[55],self.cells[56],self.cells[70],self.cells[71], nil]];
    self.diamonds[17] = [[Diamond alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[59],self.cells[60],self.cells[74],self.cells[75], nil]];
    self.diamonds[18] = [[Diamond alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[64],self.cells[65],self.cells[76],self.cells[77], nil]];
    self.diamonds[19] = [[Diamond alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[68],self.cells[69],self.cells[80],self.cells[81], nil]];
    self.diamonds[20] = [[Diamond alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[72],self.cells[73],self.cells[84],self.cells[85], nil]];
    self.diamonds[21] = [[Diamond alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[78],self.cells[79],self.cells[86],self.cells[87], nil]];
    self.diamonds[22] = [[Diamond alloc]initWithCells: [[NSMutableArray alloc] initWithObjects:self.cells[82],self.cells[83],self.cells[90],self.cells[91], nil]];
    
}

#pragma mark - Saving and Restoring

-(void)encodeWithCoder:(NSCoder *)Coder
{
    [Coder encodeInteger:self.savedTimer forKey:@"savedTimer"];
    [Coder encodeInt:self.difficultyLevel forKey:@"difficultyLevel"];
    [Coder encodeObject:self.cells forKey:@"cells"];
    [Coder encodeObject:self.diamonds forKey:@"diamonds"];
    [Coder encodeObject:self.squares forKey:@"squares"];
}

-(id)initWithCoder:(NSCoder *)Decoder
{
    if (self = [super init]) {
        [self setSavedTimer: [Decoder decodeIntegerForKey:@"savedTimer"]];
        [self setDifficultyLevel:[Decoder decodeIntForKey:@"difficultyLevel"]];
        [self setCells: [Decoder decodeObjectForKey:@"cells"]];
        [self setDiamonds: [Decoder decodeObjectForKey:@"diamonds"]];
        [self setSquares: [Decoder decodeObjectForKey:@"squares"]];
    }
    
    return self;
}

@end
