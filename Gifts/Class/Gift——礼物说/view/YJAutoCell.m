//
//  YJAutoCell.m
//  Gifts
//
//  Created by yjadair on 15/11/12.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJAutoCell.h"
#import "YJAutoScrollerView.h"
#import "YJQuickLoginButton.h"
#import "YJGiftBanner.h"
#import "YJGiftPromotion.h"
#import <SDImageCache.h>
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>


#define YJPromotionUrl @"http://api.liwushuo.com/v2/promotions?gender=1&generation=1"
#define YJBannerUrl @"http://api.liwushuo.com/v2/banners?channel=iOS"
@interface YJAutoCell()
@property (weak, nonatomic) IBOutlet UIView *promotionView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic)  YJAutoScrollerView *autoSV;

/*广告信息*/
@property (strong, nonatomic) NSMutableArray *giftBannersArr;
/*网络请求管理者*/
@property (strong, nonatomic) AFHTTPRequestOperationManager *manager;
@end
@implementation YJAutoCell
- (AFHTTPRequestOperationManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPRequestOperationManager manager];
    }
    return _manager;
}
- (NSMutableArray *)giftBannersArr{
    if (!_giftBannersArr) {
        _giftBannersArr = [NSMutableArray array];
    }
    return _giftBannersArr;
}

#pragma mark 获取广告信息
- (void)awakeFromNib {

    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [self.manager GET:YJBannerUrl parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSArray *bannersArr = [YJGiftBanner mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"banners"]];
        
        //设置广告
        [self addAuto:bannersArr];
        
        //设置promotion信息
        [self getPromotionsUrlAFNetwork];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
}
#pragma mark 设置广告
- (void)addAuto:(NSArray *)bannersArr{
    
    YJAutoScrollerView *autoSV = [[YJAutoScrollerView alloc]initWithFrame:CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    self.autoSV = autoSV;
    
    NSMutableArray *imageArr = [NSMutableArray array];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        for (int i = 0; i < bannersArr.count; i++) {
            YJGiftBanner *giftBanner = bannersArr[i];
            
            UIImageView *imageView = [[UIImageView alloc]init];
            [imageView sd_setImageWithURL:[NSURL URLWithString:giftBanner.image_url]];
            
            [imageArr addObject:imageView];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            autoSV.imageViewAry = imageArr;
            [self.scrollView addSubview:autoSV];
            [autoSV shouldAutoShow:YES];
        });
        
    });
}

#pragma mark 获取promotion图片地址和标题
- (void)getPromotionsUrlAFNetwork{
    
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [self.manager GET:YJPromotionUrl parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSArray *promotionArr = [YJGiftPromotion mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"promotions"]];
        
        //设置promotion
        [self setupPromotion:promotionArr];
      
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}
#pragma mark -设置promotion
- (void)setupPromotion:(NSArray *)promotionArr{
    
    for (int i = 0; i < promotionArr.count; i++) {
        
        //取出promotionBtn对应的模型数据
        YJGiftPromotion *giftPromotion = promotionArr[i];
        YJQuickLoginButton *btn = self.promotionView.subviews[i];
        
        //设置图片
        [btn sd_setImageWithURL:[NSURL URLWithString:giftPromotion.icon_url] forState:(UIControlStateNormal) placeholderImage:[UIImage imageNamed:@"HomePagePlaceHolder"]];
        
        //设置文字
        NSMutableDictionary *titleDict = [NSMutableDictionary dictionary];
        titleDict[NSFontAttributeName] = [UIFont systemFontOfSize:13];
        titleDict[NSForegroundColorAttributeName] = [UIColor colorWithHexString:giftPromotion.color];
        NSAttributedString *attString = [[NSAttributedString alloc]initWithString:giftPromotion.title attributes:titleDict];
        
        [btn setAttributedTitle:attString forState:(UIControlStateNormal)];

    }
}


+ (NSString *)ID{
    
    return @"autoCell";
}

+ (YJAutoCell *)autoCell{
    return [[NSBundle mainBundle]loadNibNamed:@"YJAutoCell" owner:nil options:nil][0];
}
- (CGFloat)cellHeight{
    return CGRectGetMaxY(self.promotionView.frame);
}
@end
