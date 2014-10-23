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
#import "HomeNewsCell.h"

#import "NewsDetailViewController.h"

#define kPageSize 10

@interface HomePageViewController ()<HMBannerViewDelegate>{
    BOOL _isHeaderRereshing;    //是否下拉更新
    
    NSInteger _pageIndex;       //页索引
    NSInteger _tempPageIndex;   //temp页索引
    NSInteger _pageCount;       //页数
    
    HMBannerView *_bannerView;
}

@property (nonatomic, strong) NSMutableArray *recordArray;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.recordArray = [NSMutableArray array];
    
    [self initBannerView:nil];
    
    
    [self setupRefresh];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private
- (void) loadData {
    //digest=1&startPos=0&pageSize=1

    NSDictionary *parameters = @{@"startPos": [NSNumber numberWithInt: _pageIndex * kPageSize],
                                 @"pageSize": [NSNumber numberWithInt:kPageSize]
                                 };
    [[GunnersAFManager sharedInstance] getHttpMethod:kHttpMethod_articleList parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
         [self handleLoadedResult:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error.userInfo);
    }];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recordArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell" forIndexPath:indexPath];
    
    // Configure the cell...
    /*
     
     {
         author = "";
         "category_id" = 8;
         "category_name" = "\U8db3\U5f69";
         digest = a;
         id = 52;
         likes = 0;
         pubdate = "2014-10-22 22:56:17";
         thumbnail = "http://rwsa.qiniudn.com/articles/1413989728-banner01.png";
         title = "\U4e09\U4eba\U5408\U4e70\U8db3\U5f69\U4e2d\U5927\U5956 \U91d1\U534e\U6d66\U6c5f\U5f69\U6c11\U6536\U83b754\U4e07\U5143";
         unlikes = 0;
     }
     
     */
    NSDictionary *newInfoDic = self.recordArray[indexPath.row];
    
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    
    NSURL *imageURL = [NSURL URLWithString:newInfoDic[@"thumbnail"]];
    
    if ([imageCache diskImageExistsWithKey:[imageURL absoluteString]]) {
        [cell.newsImageView setImage:[imageCache imageFromDiskCacheForKey:[imageURL absoluteString]]];
    } else {
        [cell.newsImageView sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"news_image_holder"]];
    }
    
    cell.newsTitleLabel.text = newInfoDic[@"title"];
    cell.newsDetailLabel.text = newInfoDic[@"digest"];
    
    return cell;
}

#pragma mark - Table View Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"toNewsDetail" sender:self];
}

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

-(void) handleLoadedResult:(NSDictionary *)resultDic
{
    NSInteger successFlag = [resultDic[@"errcode"] integerValue];
    if (successFlag == 0)
    {
        NSArray *resutArray = resultDic[@"result"];
        if (resutArray.count>0)
        {
            if (_isHeaderRereshing)
            {
                [self.recordArray setArray:resutArray];
                _pageIndex = 1;
            }
            else
            {
                [self.recordArray addObjectsFromArray:resutArray];
                _pageIndex++;
            }
            
            //[self.tableView reloadData];
            [self endRefresh];
        }
        else{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.tableView headerEndRefreshing];
                [self.tableView footerEndRefreshing];
            });
        }
    }
    else
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView headerEndRefreshing];
            [self.tableView footerEndRefreshing];
        });
    }
}

-(void)endRefresh
{
    if (_isHeaderRereshing)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.tableView headerEndRefreshing];
        });
    }
    else
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.tableView footerEndRefreshing];
        });
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

#pragma mark - MJRefresh
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableView headerBeginRefreshing];
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [[GunnersAFManager sharedInstance] cancelHttpMethod:kHttpMethod_articleList];
    
    _isHeaderRereshing = YES;
    _pageIndex = 0;
    _tempPageIndex = 1;
    [self loadData];
}

- (void)footerRereshing
{
    [[GunnersAFManager sharedInstance] cancelHttpMethod:kHttpMethod_articleList];
    
    _isHeaderRereshing = NO;
    
    _tempPageIndex = _pageIndex + 1;
    [self loadData];
    
}



 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier isEqualToString:@"toNewsDetail"]) {
         NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
         
         NewsDetailViewController *detailViewCtl = segue.destinationViewController;
         detailViewCtl.newsInfoDic = self.recordArray[indexPath.row];
     }
 }


@end

