//
//  ZSDStaticWebViewController.m
//  Qian100
//
//  Created by Happy on 14-9-29.
//  Copyright (c) 2014年 ZOSENDA. All rights reserved.
//

#import "ZSDStaticWebViewController.h"

@interface ZSDStaticWebViewController ()

@end

@implementation ZSDStaticWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    NSURL *url = [[NSBundle mainBundle] URLForResource:self.htmlName withExtension:@"html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
