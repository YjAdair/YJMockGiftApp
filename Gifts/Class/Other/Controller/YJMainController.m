//
//  YJMainController.m
//  Gifts
//
//  Created by yjadair on 15/11/8.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJMainController.h"

#import "YJMeViewController.h"
#import "YJHotViewController.h"
#import "YJGiftViewController.h"
#import "YJClssifyViewController.h"
#import "YJMainNacController.h"

#import "YJMeNavController.h"
@interface YJMainController ()

@end

@implementation YJMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabBarItemTitle];
    [self addOneViewController];

}
- (void)setTabBarItemTitle{
    //获取UITabBarItem
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    //设置普通状态下的文字属性
    NSMutableDictionary *norDict = [NSMutableDictionary dictionary];
    norDict[NSForegroundColorAttributeName] = [UIColor grayColor];
    norDict[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [tabBarItem setTitleTextAttributes:norDict forState:(UIControlStateNormal)];

    //设置选中状态下的文字属性
    NSMutableDictionary *selDict = [NSMutableDictionary dictionary];
    selDict[NSForegroundColorAttributeName] = [UIColor redColor];
    selDict[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [tabBarItem setTitleTextAttributes:selDict forState:(UIControlStateSelected)];
}

- (void)addOneViewController{
    
    [self setupNavController:[[YJGiftViewController alloc] init] NorImage:[UIImage imageOriginImage:@"TabBar_home"] SelImage:[UIImage imageOriginImage:@"TabBar_home_selected"] Title:@"礼物说"];
    [self setupNavController:[[YJHotViewController alloc] init] NorImage:[UIImage imageOriginImage:@"TabBar_gift"] SelImage:[UIImage imageOriginImage:@"TabBar_gift_selected"] Title:@"热门"];
    [self setupNavController:[[YJClssifyViewController alloc] init] NorImage:[UIImage imageOriginImage:@"TabBar_category"] SelImage:[UIImage imageOriginImage:@"TabBar_category_selected"] Title:@"分类"];
    [self setupNavController:[[YJMeViewController alloc] init] NorImage:[UIImage imageOriginImage:@"TabBar_me_boy"] SelImage:[UIImage imageOriginImage:@"TabBar_me_boy_selected"] Title:@"我"];
    

}

- (void)setupNavController:(UIViewController *)VC NorImage:(UIImage *)normalImage SelImage:(UIImage *)selectImage Title:(NSString *)title{
        UINavigationController *nav = [[YJMainNacController alloc]initWithRootViewController:VC];
    if ([VC isKindOfClass:[YJMeViewController class]]) {
        nav = [[YJMeNavController alloc]initWithRootViewController:VC];
    }

    VC.view.backgroundColor = YJRandomColor;
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = normalImage;
    nav.tabBarItem.selectedImage = selectImage;
    [self addChildViewController:nav];
}
@end
