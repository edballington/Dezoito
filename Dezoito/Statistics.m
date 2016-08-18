//
//  Statistics.m
//  Dezoito
//
//  Created by Ed Ballington on 3/25/15.
//  Copyright (c) 2015 Ed Ballington. All rights reserved.
//

#import "Statistics.h"

@implementation Statistics

-(void)reset
{
    self.level1PuzzlesSolved = 0;
    self.level2PuzzlesSolved = 0;
    self.level3PuzzlesSolved = 0;
    self.level4PuzzlesSolved = 0;
    
    self.level1TotalTime = 0;
    self.level2TotalTime = 0;
    self.level3TotalTime = 0;
    self.level4TotalTime = 0;
    
    self.level1RecordTime = 0;
    self.level2RecordTime = 0;
    self.level3RecordTime = 0;
    self.level4RecordTime = 0;

}

-(NSInteger) allPuzzlesSolved {
    
    return (self.level1PuzzlesSolved + self.level2PuzzlesSolved + self.level3PuzzlesSolved + self.level4PuzzlesSolved);
}

-(NSInteger) allRecordTime {
    
        NSInteger lowestTime = 0;
    
        /* Create an array sorted in ascending order of the record times */
        NSArray *timesArray =  [[NSArray arrayWithObjects:[NSNumber numberWithInteger:self.level1RecordTime],
                                [NSNumber numberWithInteger:self.level2RecordTime],
                                [NSNumber numberWithInteger:self.level3RecordTime],
                                [NSNumber numberWithInteger:self.level4RecordTime],
                                nil] sortedArrayUsingSelector:@selector(compare:)];
        for (NSNumber *time in timesArray) {
            
            /* Find and return the lowest non zero time */
            if ([time integerValue] != 0 ) {
                
                lowestTime = [time integerValue];
                break;
                
            }
            
        }
        
        return lowestTime;
    
}

-(NSInteger) averageForLevel:(NSInteger)level {
    
    NSInteger average;
    
    switch (level-1) {
        case 0:
            if (self.level1PuzzlesSolved == 0) {
                average = 0;
            }
            else {
                average = rintl(self.level1TotalTime / self.level1PuzzlesSolved);
            }
            break;
            
        case 1:
            if (self.level2PuzzlesSolved == 0) {
                average = 0;
            }
            else {
                average = rintl(self.level2TotalTime / self.level2PuzzlesSolved);
            }
            break;
            
        case 2:
            if (self.level3PuzzlesSolved == 0) {
                average = 0;
            }
            else {
                average = rintl(self.level3TotalTime / self.level3PuzzlesSolved);
            }
            break;
            
        case 3:
            if (self.level4PuzzlesSolved == 0) {
                average = 0;
            }
            else {
                average = rintl(self.level4TotalTime / self.level4PuzzlesSolved);
            }
            break;
            
        default:
            average = 0;
            break;
    }
    
    return average;
}

-(NSInteger)compositeAverage {
    
    NSInteger average;
    NSInteger totalTime = (self.level1TotalTime + self.level2TotalTime + self.level3TotalTime + self.level4TotalTime);
    
    if ([self allPuzzlesSolved] == 0) {
        average = 0;
    } else {
        
        average = rintl(totalTime / [self allPuzzlesSolved]);
    }
    
    return average;
    
}

-(void)encodeWithCoder:(NSCoder *)Coder {
    
    [Coder encodeInteger:self.level1PuzzlesSolved forKey:@"level1PuzzlesSolved"];
    [Coder encodeInteger:self.level2PuzzlesSolved forKey:@"level2PuzzlesSolved"];
    [Coder encodeInteger:self.level3PuzzlesSolved forKey:@"level3PuzzlesSolved"];
    [Coder encodeInteger:self.level4PuzzlesSolved forKey:@"level4PuzzlesSolved"];
    [Coder encodeInteger:self.level1TotalTime forKey:@"level1TotalTime"];
    [Coder encodeInteger:self.level2TotalTime forKey:@"level2TotalTime"];
    [Coder encodeInteger:self.level3TotalTime forKey:@"level3TotalTime"];
    [Coder encodeInteger:self.level4TotalTime forKey:@"level4TotalTime"];
    [Coder encodeInteger:self.level1RecordTime forKey:@"level1RecordTime"];
    [Coder encodeInteger:self.level2RecordTime forKey:@"level2RecordTime"];
    [Coder encodeInteger:self.level3RecordTime forKey:@"level3RecordTime"];
    [Coder encodeInteger:self.level4RecordTime forKey:@"level4RecordTime"];

}

-(id)initWithCoder:(NSCoder *)Decoder {
    
    if (self = [super init]) {
        [self setLevel1PuzzlesSolved: [Decoder decodeIntegerForKey:@"level1PuzzlesSolved"]];
        [self setLevel2PuzzlesSolved: [Decoder decodeIntegerForKey:@"level2PuzzlesSolved"]];
        [self setLevel3PuzzlesSolved: [Decoder decodeIntegerForKey:@"level3PuzzlesSolved"]];
        [self setLevel4PuzzlesSolved: [Decoder decodeIntegerForKey:@"level4PuzzlesSolved"]];
        [self setLevel1TotalTime: [Decoder decodeIntegerForKey:@"level1TotalTime"]];
        [self setLevel2TotalTime: [Decoder decodeIntegerForKey:@"level2TotalTime"]];
        [self setLevel3TotalTime: [Decoder decodeIntegerForKey:@"level3TotalTime"]];
        [self setLevel4TotalTime: [Decoder decodeIntegerForKey:@"level4TotalTime"]];
        [self setLevel1RecordTime:[Decoder decodeIntegerForKey:@"level1RecordTime"]];
        [self setLevel2RecordTime:[Decoder decodeIntegerForKey:@"level2RecordTime"]];
        [self setLevel3RecordTime:[Decoder decodeIntegerForKey:@"level3RecordTime"]];
        [self setLevel4RecordTime:[Decoder decodeIntegerForKey:@"level4RecordTime"]];
    }
    return self;

}

@end
