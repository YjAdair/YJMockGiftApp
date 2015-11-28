//
//  YJClssifyViewController.m
//  Gifts
//
//  Created by yjadair on 15/11/8.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJClssifyViewController.h"
#import "YJClassifyStrategyController.h"
#import "YJClassifyGiftController.h"
@interface YJClssifyViewController ()

@end

@implementation YJClssifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子控制器
    [self addChildVC];
    //设置导航条
    [self setupNav];
    
}

- (void)setupNav{
    
    //设置标题样式
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"攻略", @"礼物"]];
    CGRect temp = segment.frame;
    temp.size.width = 230;
    segment.frame = temp;
    segment.tintColor = [UIColor whiteColor];
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(changeShowView:) forControlEvents:(UIControlEventValueChanged)];
    [self.navigationItem setTitleView:segment];
    //设置右边Item
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithNorImage:[UIImage imageNamed:@"Feed_SearchBtn"] Target:self Action:@selector(search)];
    
    [self changeShowView:segment];
}
- (void)search{
    YJNslogFunc
}

- (void)changeShowView:(UISegmentedControl *)segment{

    if (segment.selectedSegmentIndex) {
        
        //取出对应的子控制器
        UIViewController *vc = self.childViewControllers[segment.selectedSegmentIndex];
        vc.view.frame = self.view.bounds;
        vc.view.backgroundColor = [UIColor greenColor];
        [self.view addSubview:vc.view];
        
    }else{
        
        //取出对应的子控制器
        UIViewController *vc = self.childViewControllers[segment.selectedSegmentIndex];
        vc.view.frame = self.view.bounds;
        [self.view addSubview:vc.view];
    }
    
}

- (void)addChildVC{
    
    YJClassifyStrategyController *strategyVC = [[YJClassifyStrategyController alloc]init];
    [self addChildViewController:strategyVC];
    
    YJClassifyGiftController *giftVC = [[YJClassifyGiftController alloc]init];
    [self addChildViewController:giftVC];
    
}

@end
