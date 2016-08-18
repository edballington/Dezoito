//
//  Square.h
//  Dezoito
//
//  Created by Ed Ballington on 6/19/14.
//  Copyright (c) 2014 Ed Ballington. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Puzzle.h"
#import "Cell.h"


@interface Square : NSObject <NSCoding>

@property (nonatomic, getter = isSolved) BOOL solved;
@property (strong, nonatomic) NSMutableArray *cellArray;

-(instancetype) initWithCells:(NSMutableArray *) memberCells;

-(void)encodeWithCoder:(NSCoder *)Coder;

-(id)initWithCoder:(NSCoder *)Decoder;

@end