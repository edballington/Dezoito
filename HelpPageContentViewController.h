//
//  HelpPageContentViewController.h
//  Dezoito
//
//  Created by Ed Ballington on 6/15/15.
//  Copyright (c) 2015 Ed Ballington. All rights reserved.
//

#import "ViewController.h"

@interface HelpPageContentViewController : ViewController
@property (weak, nonatomic) IBOutlet UIWebView *helpTextWebView;

@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *helpTextFile;

@end
