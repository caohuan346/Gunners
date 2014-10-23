//
//  HomeNavViewController.m
//  Qian100
//
//  Created by Happy on 14-8-25.
//  Copyright (c) 2014年 ZOSENDA. All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationViewController

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
    self.interactivePopGestureRecognizer.enabled = YES;
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    if (viewController.navigationItem.leftBarButtonItem== nil && [self.viewControllers count] > 1) {
        viewController.navigationItem.leftBarButtonItem =[self customizeLeftBackButton];
    } 
}

- (UIBarButtonItem*)customizeLeftBackButton
{
    UIImage *image=[UIImage imageNamed:@"nav_back"];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, image.size.width, image.size.height);
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return backItem;
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

#pragma UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.viewControllers.count == 1) {
        return NO;
    }else
    {
        return YES;
    }
}

@end
