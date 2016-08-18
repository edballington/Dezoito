//
//  Cell.m
//  Dezoito
//
//  Created by Ed Ballington on 6/13/14.
//  Copyright (c) 2014 Ed Ballington. All rights reserved.
//

#import "Cell.h" 

@implementation Cell


-(void)encodeWithCoder:(NSCoder *)Coder
{
    [Coder encodeInteger:self.cellContents forKey:@"cellContents"];
    [Coder encodeBool:self.locked forKey:@"locked"];
    [Coder encodeBool:self.selected forKey:@"selected"];
    [Coder encodeBool:self.solved forKey:@"solved"];
}

-(id)initWithCoder:(NSCoder *)Decoder
{
    if (self = [super init]) {
        [self setCellContents: [Decoder decodeIntegerForKey:@"cellContents"]];
        [self setLocked: [Decoder decodeBoolForKey:@"locked"]];
        [self setSelected: [Decoder decodeBoolForKey:@"selected"]];
        [self setSolved: [Decoder decodeBoolForKey:@"solved"]];
    }
    
    return self;
}

@end
