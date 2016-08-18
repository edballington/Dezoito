//
//  Square.m
//  Dezoito
//
//  Created by Ed Ballington on 6/19/14.
//  Copyright (c) 2014 Ed Ballington. All rights reserved.
//

#import "Square.h"

@implementation Square


-(instancetype) initWithCells:(NSMutableArray *)memberCells
{
    self = [super init];
    
    if (self) {
        self.solved = false;
    }
    
    self.cellArray = memberCells;
    
    return self;
}


// Check to see if square is solved - all cells non blank and no duplicates

-(BOOL) isSolved
{
    
    //Fast enumeration through all cells in the square to extract contents and then sort it
    
    NSMutableArray *contentsArray = [[NSMutableArray alloc]init];
    
    for (Cell *cell in self.cellArray) {
        [contentsArray addObject:[NSNumber numberWithInteger:cell.cellContents]];
    }
    [contentsArray sortUsingSelector:@selector(compare:)];
    
    //Check if square is solved (no blanks and no duplicates) by comparing contents against an array of numbers 1-8

    if ([contentsArray isEqualToArray:
         [NSArray arrayWithObjects:
          [NSNumber numberWithInt:1],
          [NSNumber numberWithInt:2],
          [NSNumber numberWithInt:3],
          [NSNumber numberWithInt:4],
          [NSNumber numberWithInt:5],
          [NSNumber numberWithInt:6],
          [NSNumber numberWithInt:7],
          [NSNumber numberWithInt:8], nil]])
        {
        _solved = true;
        } else
        {
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
