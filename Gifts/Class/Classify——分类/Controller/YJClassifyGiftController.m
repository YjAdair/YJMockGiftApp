//
//  YJClassifyController.m
//  Gifts
//
//  Created by yjadair on 15/11/21.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJClassifyGiftController.h"
#import "YJCategories.h"
#import "YJSubcategories.h"
#import <MJExtension.h>
#import "YJSubcategoryView.h"
#import <UIButton+WebCache.h>
#import "YJSubCategoryBtn.h"
@interface YJClassifyGiftController()
@property (weak, nonatomic) IBOutlet UIView *godSelect;
@property (weak, nonatomic) IBOutlet UIScrollView *finderScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *subCategoryScrollView;
/*<#name#>*/
@property (weak, nonatomic) UIButton *selButton;
@property (strong, nonatomic) AFHTTPSessionManager *manager;
@property (weak, nonatomic) UIView *sliderView;
/*<#name#>*/
@property (strong, nonatomic) NSMutableArray *subViewsArr;
/*<#name#>*/
@property (strong, nonatomic) NSMutableArray *categorieInfoArr;
@end
@implementation YJClassifyGiftController

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (NSMutableArray *)subViewsArr{
    if (!_subViewsArr) {
        _subViewsArr = [NSMutableArray array];
    }
    return _subViewsArr;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selected)];
    [self.godSelect addGestureRecognizer:tap];
    [self getCategoriesInfo];
}

- (void)selected{
   YJNslogFunc
}

- (void)getCategoriesInfo{
    
    [self.manager GET:@"http://api.liwushuo.com/v2/item_categories/tree?" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {

        NSMutableArray *categorieInfoArr = [NSMutableArray array];
        self.categorieInfoArr = categorieInfoArr;
        NSArray *categorieArr = responseObject[@"data"][@"categories"];
        for (int i = 0; i< categorieArr.count; i++) {
            [categorieInfoArr addObject:[YJCategories mj_objectWithKeyValues:categorieArr[i]]];
        }
        
        [self setupSubcategoryView:categorieInfoArr];
        [self setupCategories:categorieInfoArr];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark - 设置左边分类
- (void)setupCategories:(NSMutableArray *)categorieInfoArr{
    
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    CGFloat buttonW = self.finderScrollView.yj_width;
    CGFloat buttonH = 50;
    
    for (int i = 0; i < categorieInfoArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        YJCategories *categories = categorieInfoArr[i];
        
        [button setTitle:categories.name forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor redColor] forState:(UIControlStateSelected)];
        button.tag = i + 1;
        buttonY = i * buttonH;
        [button setBackgroundColor:[UIColor colorWithRed:245.0 / 255 green:245.0 / 255 blue:245.0 / 255 alpha:1.0]];
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        [button addTarget:self action:@selector(selectGategy:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.finderScrollView addSubview:button];
    }
    
    UIView *sliderView = [[UIView alloc]init];
    self.sliderView = sliderView;
    sliderView.backgroundColor = [UIColor redColor];
    sliderView.frame = CGRectMake(0, 0, 3, buttonH);
    [self.finderScrollView addSubview:sliderView];
    
    self.finderScrollView.contentSize = CGSizeMake(0, categorieInfoArr.count * buttonH);
    self.finderScrollView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);

    UIButton *firstBtn = [self.finderScrollView.subviews firstObject];
    [self selectGategy:firstBtn];
}

- (void)selectGategy:(UIButton *)button{
    
    [self.selButton setBackgroundColor:[UIColor colorWithRed:245.0 / 255 green:245.0 / 255 blue:245.0 / 255 alpha:1.0]];
    [button setBackgroundColor:[UIColor whiteColor]];
    self.selButton = button;
    self.sliderView.yj_y = button.yj_y;
    
    YJSubcategoryView *subView = self.subViewsArr[button.tag - 1];

    [self.subCategoryScrollView setContentOffset:CGPointMake(0, subView.yj_y) animated:YES];
    
}
#pragma mark - 设置分类详情
- (void)setupSubcategoryView:(NSMutableArray *)categorieInfoArr{
    
    for (int i = 0; i < categorieInfoArr.count; i++) {
        
        YJSubcategoryView *subView = [[YJSubcategoryView alloc]init];
        
        [self.subViewsArr addObject:subView];
        [self.subCategoryScrollView addSubview:subView];
        
        YJCategories *categories = categorieInfoArr[i];
        CGFloat buttonX = 0;
        CGFloat buttonY = 0;
        CGFloat buttonW = self.subCategoryScrollView.yj_width / 3;
        CGFloat buttonH = buttonW;
        
        for (int i = 0; i < categories.subcategories.count ; i++) {
            
            YJSubcategories *subCategories = categories.subcategories[i];
            YJSubCategoryBtn *button = [YJSubCategoryBtn buttonWithType:(UIButtonTypeCustom)];
            button.backgroundColor = [UIColor whiteColor];
            buttonX = (i % 3) * buttonW;
            buttonY = (i / 3) * (buttonH + 20);
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            [button setTitle:subCategories.name forState:(UIControlStateNormal)];
            [button sd_setImageWithURL:[NSURL URLWithString:subCategories.icon_url] forState:(UIControlStateNormal)];
            [subView addSubview:button];

        }

        subView.frame = CGRectMake(0, i *([UIScreen mainScreen].bounds.size.height - 64-35-49), [UIScreen mainScreen].bounds.size.width - 35, [UIScreen mainScreen].bounds.size.height - 64 - 35 - 49);
    }
    
    self.subCategoryScrollView.contentSize = CGSizeMake(0, categorieInfoArr.count *([UIScreen mainScreen].bounds.size.height - 64 - 35 - 49));
    self.subCategoryScrollView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    
}
@end
