//
//  SimpleWebViewController.m
//  TheGunners
//
//  Created by Happy on 14/10/23.
//  Copyright (c) 2014年 Happy. All rights reserved.
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    NSDictionary *parameters = @{@"id": self.newsInfoDic[@"id"]};
    
    [[GunnersAFManager sharedInstance] getHttpMethod:kHttpMethod_articleDetail parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *responeseDic = responseObject;
        
        if ([responeseDic[@"errcode"] intValue] == 0) {
            NSArray *newsArray = responeseDic[@"result"];
            NSString *htmlString = newsArray[0][@"content"];
            
            [self.webView loadHTMLString:htmlString baseURL:nil];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
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
