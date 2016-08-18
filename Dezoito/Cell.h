//
//  Cell.h
//  Dezoito
//
//  Created by Ed Ballington on 6/13/14.
//  Copyright (c) 2014 Ed Ballington. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cell : NSObject <NSCoding>

@property (nonatomic) NSInteger cellContents;
@property (nonatomic, getter = isLocked) BOOL locked;
@property (nonatomic, getter = isSelected) BOOL selected;
@property (nonatomic, getter = isSolved) BOOL solved;

-(void)encodeWithCoder:(NSCoder *)Coder;

-(id)initWithCoder:(NSCoder *)Decoder;

@end
