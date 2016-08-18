//
//  Puzzle.h
//  Dezoito
//
//  Created by Ed Ballington on 6/30/14.
//  Copyright (c) 2014 Ed Ballington. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Square.h"
#import "Diamond.h"
#import "Cell.h"

@interface Puzzle : NSObject <NSCoding>
@property BOOL  solved;
@property int difficultyLevel;
@property (strong, nonatomic) NSMutableArray *cells;
@property (strong, nonatomic) NSMutableArray *squares;
@property (strong, nonatomic) NSMutableArray *diamonds;
@property (nonatomic) NSInteger savedTimer;     //current stopwatch value for saving in progress puzzles


-(instancetype) initPuzzleWithCells:(NSArray *)cellContentsArray;

-(void) initSquaresWithCells;

-(void) initDiamondsWithCells;

-(void)encodeWithCoder:(NSCoder *)Coder;

-(id)initWithCoder:(NSCoder *)Decoder;


@end
