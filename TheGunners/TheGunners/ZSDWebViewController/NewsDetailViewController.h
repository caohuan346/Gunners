//
//  SimpleWebViewController.h
//  TheGunners
//
//  Created by Happy on 14/10/23.
//  Copyright (c) 2014年 Happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailViewController : UIViewController

@property (strong, nonatomic) NSDictionary *newsInfoDic;

@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end
