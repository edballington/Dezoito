//
//  InProgressPuzzle.m
//  Dezoito
//
//  Created by Ed Ballington on 3/24/15.
//  Copyright (c) 2015 Ed Ballington. All rights reserved.
//

#import "InProgressPuzzle.h"

@implementation InProgressPuzzle

-(void)encodeWithCoder:(NSCoder *)Coder
{
    [Coder encodeObject:[NSNumber numberWithInteger:self.savedTimer] forKey:@"savedTimer"];
    [Coder encodeObject:self.cells forKey:@"cells"];
    [Coder encodeObject:self.diamonds forKey:@"diamonds"];
    [Coder encodeObject:self.squares forKey:@"squares"];
    
    
}

-(id)initWithCoder:(NSCoder *)Decoder
{
    if (self = [super init]) {
        [self setSavedTimer: [Decoder decodeObjectForKey:@"savedTimer"]];
        [self setCells: [Decoder decodeObjectForKey:@"cells"]];
        [self setDiamonds: [Decoder decodeObjectForKey:@"diamonds"]];
        [self setSquares: [Decoder decodeObjectForKey:@"squares"]];
    }
    
    return self;
}

@end
