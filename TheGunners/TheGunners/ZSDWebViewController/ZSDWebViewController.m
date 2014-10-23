//
//  ZSDWebViewController.m
//  Qian100
//
//  Created by Happy on 14-9-1.
//  Copyright (c) 2014年 ZOSENDA. All rights reserved.
//

#import "ZSDWebViewController.h"
#import "UIViewController+NJKFullScreenSupport.h"

@interface ZSDWebViewController ()

@property (nonatomic) NJKScrollFullScreen *scrollProxy;

@end

@implementation ZSDWebViewController

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
    // Do any additional setup after loading the view.
    
    _scrollProxy = [[NJKScrollFullScreen alloc] initWithForwardTarget:self.webView];
    
    self.webView.scrollView.delegate = _scrollProxy;
    _scrollProxy.delegate = self;
    
    self.webView.scalesPageToFit = YES;
    
    //[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://baidu.com"]]];
    
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

// same as ViewController
#pragma mark -
#pragma mark NJKScrollFullScreenDelegate

- (void)scrollFullScreen:(NJKScrollFullScreen *)proxy scrollViewDidScrollUp:(CGFloat)deltaY
{
//    [self moveNavigtionBar:deltaY animated:YES];
//    [self moveToolbar:-deltaY animated:YES]; // move to revese direction
}

- (void)scrollFullScreen:(NJKScrollFullScreen *)proxy scrollViewDidScrollDown:(CGFloat)deltaY
{
//    [self moveNavigtionBar:deltaY animated:YES];
//    [self moveToolbar:-deltaY animated:YES];
}

- (void)scrollFullScreenScrollViewDidEndDraggingScrollUp:(NJKScrollFullScreen *)proxy
{
//    [self hideNavigationBar:YES];
//    [self hideToolbar:YES];
}

- (void)scrollFullScreenScrollViewDidEndDraggingScrollDown:(NJKScrollFullScreen *)proxy
{
    [self showNavigationBar:YES];
    [self showToolbar:YES];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [_scrollProxy reset];
    [self showNavigationBar:YES];
    [self showToolbar:YES];
}



@end
