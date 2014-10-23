//
//  HomePageViewController.m
//  TheGunners
//
//  Created by hc on 14/10/22.
//  Copyright (c) 2014年 Happy. All rights reserved.
//

#import "HomePageViewController.h"
#import "HMBannerView.h"
#import "ZSDWebViewController.h"

#import "MJRefresh.h"
#import "GunnersAFManager.h"

@interface HomePageViewController ()<HMBannerViewDelegate>{
    BOOL _isHeaderRereshing;    //是否下拉更新
    
    NSInteger _pageIndex;       //页索引
    NSInteger _tempPageIndex;   //temp页索引
    NSInteger _pageCount;       //页数
    
    HMBannerView *_bannerView;
}
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initBannerView:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private
- (void) loadData {
    //digest=1&startPos=0&pageSize=1
    NSDictionary *parameters = @{@"digest": @1,
                                 @"startPos": @0,
                                 @"pageSize": @10
                                 };
    [[GunnersAFManager sharedInstance] GET:@"http://rwsa.sinaapp.com/api/article/list" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *resultDic = responseObject;
        NSLog(@"%@",resultDic);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
    /*
     self.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
     [self.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"content-type"];
     */
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - private
- (void)initBannerView:(NSArray *)bannerList
{
    /*
     NSMutableArray *banners = [NSMutableArray arrayWithCapacity:0];
     for (NSDictionary *imageDic in bannerList) {
     NSDictionary *bannerDic = [NSDictionary dictionaryWithObjectsAndKeys:
     imageDic[@"Img"], @"img_url",
     imageDic[@"Url"], @"action_url", nil];
     [banners addObject:bannerDic];
     }
     */
    
    NSMutableArray *banners = [NSMutableArray arrayWithCapacity:0];
    for (int i=0;i<5;i++) {
        NSDictionary *bannerDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                   @"http://c.hiphotos.bdimg.com/album/w%3D2048/sign=4574e2db34fae6cd0cb4ac613b8b0e24/728da9773912b31b620ecec58718367adbb4e1f8.jpg", @"img_url",
                                   @"http://c.hiphotos.bdimg.com/album/w%3D2048/sign=4574e2db34fae6cd0cb4ac613b8b0e24/728da9773912b31b620ecec58718367adbb4e1f8.jpg", @"action_url", nil];
        [banners addObject:bannerDic];
    }
    
    if (_isHeaderRereshing && _bannerView) {
        /*
         NSDictionary *bannerDic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"http://pic2.ooopic.com/10/54/72/81b1OOOPIC9f.jpg", @"img_url", nil];
         [banners addObject:bannerDic1];
         */
        [_bannerView reloadBannerWithData:banners];
    }
    else
    {
        HMBannerView *bannerView = [[HMBannerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 134) scrollDirection:ScrollDirectionLandscape images:banners];
        [bannerView setRollingDelayTime:4.0];
        bannerView.delegate = self;
        [bannerView setSquare:0];
        [bannerView setPageControlStyle:PageStyle_Middle];
        [self.homeTopView addSubview:bannerView];
        _bannerView = bannerView;
        //[bannerView showClose:YES];
        
        [bannerView startDownloadImage];
    }
}

#pragma mark HMBannerView Delegate
- (void)imageCachedDidFinish:(HMBannerView *)bannerView
{
    [self.homeTopView addSubview:bannerView];
    [bannerView startRolling];
}

- (void)bannerView:(HMBannerView *)bannerView didSelectImageView:(NSInteger)index withData:(NSDictionary *)bannerData
{
    if ([bannerData[@"action_url"] length] > 0) {
        NSURL *url = [NSURL URLWithString:bannerData[@"action_url"]];
        ZSDWebViewController *webViewController = [[ZSDWebViewController alloc] initWithURL:url];
        webViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webViewController animated:YES];
    }
}

- (void)bannerViewdidClosed:(HMBannerView *)bannerView;
{
    if (bannerView.superview)
    {
        [bannerView removeFromSuperview];
    }
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

