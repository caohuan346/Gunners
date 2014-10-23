//
//  HomeNewsCell.h
//  TheGunners
//
//  Created by hc on 14/10/22.
//  Copyright (c) 2014年 Happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeNewsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;
@property (weak, nonatomic) IBOutlet UILabel *newsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *newsDetailLabel;

@end
