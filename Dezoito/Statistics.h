//
//  Statistics.h
//  Dezoito
//
//  Created by Ed Ballington on 3/25/15.
//  Copyright (c) 2015 Ed Ballington. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Statistics : NSObject <NSCoding>

// Number of puzzles solved for various difficulty levels
@property (nonatomic) NSInteger level1PuzzlesSolved;
@property (nonatomic) NSInteger level2PuzzlesSolved;
@property (nonatomic) NSInteger level3PuzzlesSolved;
@property (nonatomic) NSInteger level4PuzzlesSolved;

// Total number of seconds to solve all of the puzzles solved for various difficulty levels
@property (nonatomic) NSInteger level1TotalTime;
@property (nonatomic) NSInteger level2TotalTime;
@property (nonatomic) NSInteger level3TotalTime;
@property (nonatomic) NSInteger level4TotalTime;

// Record time in seconds for solving puzzles for various difficulty levels
@property (nonatomic) NSInteger level1RecordTime;
@property (nonatomic) NSInteger level2RecordTime;
@property (nonatomic) NSInteger level3RecordTime;
@property (nonatomic) NSInteger level4RecordTime;


-(void)reset;

-(NSInteger) allPuzzlesSolved;
-(NSInteger) allRecordTime;
-(NSInteger) averageForLevel:(NSInteger) level;
-(NSInteger) compositeAverage;

-(void)encodeWithCoder:(NSCoder *)Coder;
-(id)initWithCoder:(NSCoder *)Decoder;

@end
