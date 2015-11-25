//
//  YJClassifyStrategySpecialCell.m
//  Gifts
//
//  Created by yjadair on 15/11/21.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJClassifyStrategySpecialCell.h"
#import <UIButton+WebCache.h>
#import "YJClassifySpecialButton.h"
@interface YJClassifyStrategySpecialCell()

@property (weak, nonatomic) IBOutlet UIScrollView *specialScrollView;
/*网络请求管理者*/
@property (strong, nonatomic) AFHTTPSessionManager *manager;
/*<#name#>*/
@property (weak, nonatomic) UIButton *lastBtn;
@end
@implementation YJClassifyStrategySpecialCell

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)awakeFromNib{
    
    [self.manager GET:@"http://api.liwushuo.com/v2/collections?limit=6&offset=0" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSMutableArray *bannerImageUrlArr = [NSMutableArray array];
        NSArray *bannerArr = responseObject[@"data"][@"collections"];
        for (int i = 0; i < bannerArr.count; i++) {
            [bannerImageUrlArr addObject:bannerArr[i][@"banner_image_url"]];
        }
        [self setupBanner:bannerImageUrlArr];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)setupBanner:(NSMutableArray *)bannerImageUrlArr{
    
    for (int i = 0; i < bannerImageUrlArr.count; i++) {
        
        YJClassifySpecialButton *bannerBtn = [YJClassifySpecialButton buttonWithType:(UIButtonTypeCustom)];
        [bannerBtn addTarget:self action:@selector(channelDetail) forControlEvents:(UIControlEventTouchUpInside)];
        
        [bannerBtn sd_setImageWithURL:[NSURL URLWithString:bannerImageUrlArr[i]] forState:(UIControlStateNormal)];
        bannerBtn.yj_width =  self.specialScrollView.yj_width * 0.6;
        bannerBtn.yj_height = bannerBtn.yj_width * 0.4;
        bannerBtn.yj_x = i * bannerBtn.yj_width;
        [self.specialScrollView addSubview:bannerBtn];
        
    }
    
    YJClassifySpecialButton *lastBtn = self.specialScrollView.subviews.lastObject;
    self.lastBtn = lastBtn;
    self.specialScrollView.showsHorizontalScrollIndicator = NO;
    self.specialScrollView.contentSize = CGSizeMake(bannerImageUrlArr.count * lastBtn.yj_width, 0);
}

- (void)channelDetail{
    YJNslogFunc
}
- (IBAction)checkAllContent:(id)sender {
}


- (CGFloat)cellHeight{
    
    return 37 + 10 + self.specialScrollView.yj_width * 0.6 * 0.5;
}
+ (YJClassifyStrategySpecialCell *)specialCell{
    
    return [[NSBundle mainBundle]loadNibNamed:@"YJClassifyStrategySpecialCell" owner:nil options:nil][0];
}
+ (NSString *)ID{
    return @"YJClassifyStrategySpecialCell";
}

@end
