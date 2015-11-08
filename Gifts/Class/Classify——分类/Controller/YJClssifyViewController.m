//
//  YJClssifyViewController.m
//  Gifts
//
//  Created by yjadair on 15/11/8.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJClssifyViewController.h"

@interface YJClssifyViewController ()

@end

@implementation YJClssifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"攻略", @"礼物"]];
    CGRect temp = segment.frame;
    temp.size.width = 230;
    segment.frame = temp;
    segment.tintColor = [UIColor whiteColor];
    segment.selectedSegmentIndex = 0;
    
    [self.navigationItem setTitleView:segment];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithNorImage:[UIImage imageNamed:@"Feed_SearchBtn"] Target:self Action:@selector(search)];
}
- (void)search{
    YJNslogFunc
}

@end
