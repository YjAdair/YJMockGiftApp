//
//  YJHotViewController.m
//  Gifts
//
//  Created by yjadair on 15/11/8.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJHotViewController.h"

@interface YJHotViewController ()

@end

@implementation YJHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.navigationItem setTitleView:[UILabel labelWithSize:20 TitleColor:[UIColor whiteColor] Title:@"热门"]];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithNorImage:[UIImage imageNamed:@"Feed_SearchBtn"] Target:self Action:@selector(search)];
}
- (void)search{
    YJNslogFunc
}
@end
