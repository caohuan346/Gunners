//
//  AppConfig.h
//  Qian100
//
//  Created by Happy on 14-8-28.
//  Copyright (c) 2014年 ZOSENDA. All rights reserved.
//

#ifndef TheGunners_AppConfig_h
#define TheGunners_AppConfig_h

/////////////////////////////////////////// 用户信息 ////////////////////////////////////////////
#define kUserName @"userName"

/////////////////////////////////////////// 全局通知 ////////////////////////////////////////////
//登录成功
//#define kNotificationKey_LoginSuccess @"kNotificationKey_LoginSuccess"

/////////////////////////////////////////// 接口配置 ////////////////////////////////////////////
#define kHttpBaseURL @"http://rwsa.sinaapp.com/api/"       //base url

#define kHttpServer @"http://rwsa.sinaapp.com"

//注册
#define kHttpMethod_userRegister @"user/register"
//登录
#define kHttpMethod_userLogin @"user/login"
//文章列表参数
#define kHttpMethod_articleList @"article/list"
//文章详情
#define kHttpMethod_articleDetail @"article/get"

/////////////////////////////////////////// 界面配置 ////////////////////////////////////////////
//背景色
#define kThemeBackGroundColor [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]
//主题红色
#define kThemeRedColor [UIColor colorWithRed:0.84 green:0.23 blue:0.29 alpha:1]
//边框颜色
#define kThemeBorderColor [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1].CGColor
//边框高亮颜色
#define kThemeBorderRedColor [UIColor colorWithRed:0.84 green:0.23 blue:0.29 alpha:1].CGColor

//红色按钮正常状态  #da4453
#define kRedButtonNormalColor [UIColor colorWithRed:0.84 green:0.23 blue:0.29 alpha:1]
//红色按钮点击状态  #c01c26
#define kRedButtonClickedColor [UIColor colorWithRed:0.72 green:0.1 blue:0.13 alpha:1]

//黄色按钮正常状态  #da4453
#define kYellowButtonNormalColor [UIColor colorWithRed:1 green:0.69 blue:0.02 alpha:1]
//黄色按钮点击状态  #c01c26
#define kYellowButtonClickedColor [UIColor colorWithRed:1 green:0.53 blue:0.02 alpha:1]

//蓝色按钮正常状态  #da4453
#define kBlueButtonNormalColor [UIColor colorWithRed:0.18 green:0.77 blue:0.84 alpha:1]
//蓝色按钮点击状态  #c01c26
#define kBlueButtonClickedColor [UIColor colorWithRed:0.32 green:0.71 blue:0.80 alpha:1]

//红色按钮失效下的颜色 #c6c6c6
#define kButtonDisabledGrayColor [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1]

//灰度中  #989898
#define kGrayFontColor [UIColor colorWithRed:0.55 green:0.55 blue:0.55 alpha:1];
//灰度高  #232323
#define kBlackFontColor [UIColor colorWithRed:0.12 green:0.12 blue:0.12 alpha:1];


#endif
