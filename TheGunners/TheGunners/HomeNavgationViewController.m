//
//  HomeNavgationViewController.m
//  Qian100
//
//  Created by Happy on 14-9-10.
//  Copyright (c) 2014年 ZOSENDA. All rights reserved.
//

#import "HomeNavgationViewController.h"
#import "HomePageViewController.h"

@interface HomeNavgationViewController ()

@end

@implementation HomeNavgationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)init{
    if (self = [super init]) {
        
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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