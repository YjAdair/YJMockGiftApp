//
//  YJGiftViewController.m
//  Gifts
//
//  Created by yjadair on 15/11/8.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJGiftViewController.h"

@interface YJGiftViewController ()

@end

@implementation YJGiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self.navigationItem setTitleView:[UILabel labelWithSize:20 TitleColor:[UIColor whiteColor] Title:@"礼物说"]];
    
    UIBarButtonItem *nightItem = [UIBarButtonItem itemWithNorImage:[UIImage imageNamed:@"icon_navigation_nightmode"] Target:self Action:@selector(search)];
    UIBarButtonItem *searchItem = [UIBarButtonItem itemWithNorImage:[UIImage imageNamed:@"Feed_SearchBtn"] Target:self Action:@selector(nightmode)];
    
    self.navigationItem.rightBarButtonItems = @[searchItem, nightItem];
}
- (void)search{
    YJNslogFunc
}
- (void)nightmode{
    YJNslogFunc
}
@end
