//
//  ZSDStaticWebViewController.h
//  Qian100
//
//  Created by Happy on 14-9-29.
//  Copyright (c) 2014年 ZOSENDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZSDStaticWebViewController : UIViewController

@property(nonatomic,copy) NSString *htmlName;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
