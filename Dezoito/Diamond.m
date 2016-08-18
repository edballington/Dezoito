//
//  Diamond.m
//  Dezoito
//
//  Created by Ed Ballington on 7/14/14.
//  Copyright (c) 2014 Ed Ballington. All rights reserved.
//

#import "Diamond.h"

@implementation Diamond


-(instancetype) initWithCells:(NSMutableArray *)memberCells
{
    self = [super init];
    
    if (self) {
        self.solved = false;
    }
    
    self.cellArray = memberCells;
    
    return self;
}


//Check to see if Diamond is solved - if no cells are blank and total of cells is 18

-(BOOL) isSolved
{

    NSUInteger total = 0;
    BOOL blankCellFound = true;
    
    for (Cell *cell in self.cellArray)
    {
        if (cell.cellContents != 0) {
            total = total + cell.cellContents;
            blankCellFound = false;
        } else {
            blankCellFound = true;
            break;
        }

    }
    
    if (total == 18 && blankCellFound == false) {
        _solved = true;
    } else {
     _solved = false;
    }
    
    return _solved;
    
}

-(void)encodeWithCoder:(NSCoder *)Coder
{
    [Coder encodeBool:self.solved forKey:@"solved"];
    [Coder encodeObject:self.cellArray forKey:@"cellArray"];
}

-(id)initWithCoder:(NSCoder *)Decoder
{
    if (self = [super init]) {
        [self setSolved: [Decoder decodeBoolForKey:@"solved"]];
        [self setCellArray: [Decoder decodeObjectForKey:@"cellArray"]];
    }
    
    return self;
}

@end
