//
//  AppDelegate.m
//  TheGunners
//
//  Created by Happy on 14/10/21.
//  Copyright (c) 2014年 Happy. All rights reserved.
//

#import "AppDelegate.h"

#import "MainTabBarViewController.h"

#import "HomeNavgationViewController.h"
#import "GunnerFansNavgationViewController.h"
#import "MySiteNavgationViewController.h"

#import "HomePageViewController.h"
#import "GunnerFansViewController.h"
#import "MySiteViewController.h"

#import "UIImage+ImageWithColor.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self customizeGlobalUIStyle];
    
    [self initViewControllers];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - private
/**
 *  定制UI风格，如果不同sdk版本下的导航条、状态栏等
 */
- (void)customizeGlobalUIStyle
{
    //状态栏
    if (IOS_VERSION >= 7.0)
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    
    //导航条
    UIColor *topColor = kThemeRedColor;
    UIImage *image = [UIImage imageWithColor:topColor];
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    //title
    [navBar setTitleTextAttributes:@{UITextAttributeTextColor: [UIColor whiteColor],
                                     UITextAttributeFont:[UIFont boldSystemFontOfSize:20]}];
    
}

-(void)initViewControllers
{
    MainTabBarViewController *tabViewController = [[MainTabBarViewController alloc] init];
    tabViewController.delegate = self;
    
    //Tab1
    UIStoryboard *mainSB=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    HomePageViewController *homePage = [mainSB instantiateViewControllerWithIdentifier:@"HomePageViewController"];
//    homePage.tabBarItem.title = @"红白视野";
    homePage.title = @"红·白阿森纳";
    HomeNavgationViewController *nav1 = [[HomeNavgationViewController alloc]  initWithRootViewController:homePage];
    nav1.tabBarItem.title = @"红白视野";
    //Tab2
    GunnerFansViewController *investmentList = [mainSB instantiateViewControllerWithIdentifier:@"GunnerFansViewController"];
    investmentList.tabBarItem.title = @"枪迷心声";
    investmentList.title = @"枪迷心声";
    GunnerFansNavgationViewController *nav2 = [[GunnerFansNavgationViewController alloc]  initWithRootViewController:investmentList];
    
    //Tab3
    MySiteViewController *mySite = [mainSB instantiateViewControllerWithIdentifier:@"MySiteViewController"];
    mySite.tabBarItem.title = @"我的手枪";
    mySite.title = @"我的手枪";
    MySiteNavgationViewController *nav3 = [[MySiteNavgationViewController alloc] initWithRootViewController:mySite];
    tabViewController.viewControllers = @[nav1,nav2,nav3];
    
    //tabbarItem customize
    UIImage *tabBarImage = [UIImage imageWithColor:[UIColor whiteColor]];
    [[UITabBar appearance] setBackgroundImage:tabBarImage];
    
    NSArray *tabBarArray = tabViewController.tabBar.items;
    NSInteger count = tabBarArray.count;
    for (int i = 0; i < count; i++) {
        //[item setSelectedImage:[UIImage imageNamed:@"nav_button_account_tap"]];
        UITabBarItem *tabBarItem = tabBarArray[i];
        NSString *selectImgName = [NSString stringWithFormat:@"tab_button_%d_tap",i];
        NSString *unSelectImgName = [NSString stringWithFormat:@"tab_button_%d",i];
        UIImage *selectImg = [UIImage imageNamed:selectImgName];
        if (IOS_VERSION_7_OR_ABOVE) {
            selectImg = [selectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        
        [tabBarItem setFinishedSelectedImage:selectImg withFinishedUnselectedImage:[UIImage imageNamed:unSelectImgName]];
        [tabBarItem setTitleTextAttributes:@{ UITextAttributeTextColor:[UIColor redColor],
                                              UITextAttributeFont: [UIFont systemFontOfSize:13]
                                              } forState:UIControlStateSelected];
    }
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:tabViewController];
    
    [self.window makeKeyAndVisible];
}

#pragma mark - UITabBarControllerDelegate

//进入我的钱一百前需登录
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    /*
    NSInteger index = tabBarController.selectedIndex;
    if (index == 2)
    {
        //未登录
        if (![self checkLogInOrOut]) {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
            UIViewController *loginCtl = [storyBoard instantiateInitialViewController];
            LoginViewController *login = loginCtl.childViewControllers[0];
            //登录类型
            if (!CURRENT_USER) {
                //第一次登录
                login.loginType = Qian100LoginType_FirstLogin;
            }else
            {
                //非第一次登录
                login.loginType = Qian100LoginType_Normal;
            }
            MySiteViewController *mysite = (MySiteViewController *)viewController.childViewControllers[0];
            login.selectIndex = mysite.selectIndex;
            [tabBarController presentViewController:loginCtl animated:YES completion:NULL];
        }
    }else
    {
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center postNotificationName:@"selectIndex" object:[NSNumber numberWithInteger:index]];
    }
     */
}


@end
