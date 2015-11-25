//
//  YJAutoCell.m
//  Gifts
//
//  Created by yjadair on 15/11/12.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJHotAutoCell.h"
#import "YJAutoScrollerView.h"
#import "YJHotGiftDetail.h"
#import <UIImageView+WebCache.h>

@interface YJHotAutoCell()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic)  YJAutoScrollerView *autoSV;

@property (weak, nonatomic) IBOutlet UIView *contentViews;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
/*广告信息*/
@property (strong, nonatomic) NSMutableArray *giftBannersArr;
/*网络请求管理者*/
@property (strong, nonatomic) AFHTTPSessionManager *manager;
@end
@implementation YJHotAutoCell
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (NSMutableArray *)giftBannersArr{
    if (!_giftBannersArr) {
        _giftBannersArr = [NSMutableArray array];
    }
    return _giftBannersArr;
}

#pragma mark 获取content信息
- (void)setHotGiftItemUrl:(NSString *)hotGiftItemUrl{
    
    _hotGiftItemUrl = hotGiftItemUrl;
    
    [YJHotGiftDetail mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"descriptions" : @"description"
                 };
    }];
  
    [self.manager GET:hotGiftItemUrl parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        YJHotGiftDetail *hotGiftDetail = [YJHotGiftDetail mj_objectWithKeyValues:responseObject[@"data"]];
        
        [self addAuto:hotGiftDetail];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          NSLog(@"请求失败");
    }];

}

#pragma mark 设置广告
- (void)addAuto:(YJHotGiftDetail *)hotGiftDetail{

    YJAutoScrollerView *autoSV = [[YJAutoScrollerView alloc]initWithFrame:CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    self.autoSV = autoSV;

    self.titleLabel.text = hotGiftDetail.name;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@", hotGiftDetail.price];
    self.contentLabel.text = hotGiftDetail.descriptions;
    
    NSMutableArray *imageArr = [NSMutableArray array];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < hotGiftDetail.image_urls.count; i++) {
            
            UIImageView *imageView = [[UIImageView alloc]init];
            [imageView sd_setImageWithURL:[NSURL URLWithString:hotGiftDetail.image_urls[i]]];
            [imageArr addObject:imageView];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{

            autoSV.imageViewAry = imageArr;
            [self.scrollView addSubview:autoSV];
            [autoSV shouldAutoShow:YES];
            
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                if ([self.delegate respondsToSelector:@selector(hotAutoCell:)]) {
                    [self.delegate hotAutoCell:self];
                }
            });
        });
        
    });
}



+ (NSString *)ID{
    
    return @"YJHotAutoCell";
}

+ (YJHotAutoCell *)HotautoCell{
    return [[NSBundle mainBundle]loadNibNamed:@"YJHotAutoCell" owner:nil options:nil][0];
}
- (CGFloat)cellHeight{
    return CGRectGetMaxY(self.contentView.frame);
}
@end
