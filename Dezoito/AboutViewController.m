//
//  AboutViewController.m
//  Dezoito
//
//  Created by Ed Ballington on 4/22/15.
//  Copyright (c) 2015 Ed Ballington. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDocument:@"About Dezoito" inView:self.AboutTextWebView];
    self.AboutTextWebView.scrollView.contentInset = UIEdgeInsetsZero;


}

-(void)loadDocument:(NSString *)documentName inView:(UIWebView *)webView
{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:documentName ofType:@"htm"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    self.AboutTextWebView.scrollView.scrollEnabled = true;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
