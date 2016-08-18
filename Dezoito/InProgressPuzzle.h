//
//  InProgressPuzzle.h
//  Dezoito
//
//  Created by Ed Ballington on 3/24/15.
//  Copyright (c) 2015 Ed Ballington. All rights reserved.
//

#import "Puzzle.h"

@interface InProgressPuzzle : Puzzle <NSCoding>
@property (nonatomic) NSInteger savedTimer; //saved in progress stopwatch value in seconds

@end
