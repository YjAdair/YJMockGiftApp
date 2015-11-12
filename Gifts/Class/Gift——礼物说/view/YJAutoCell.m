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
@interface YJAutoCell()
@property (weak, nonatomic) IBOutlet UIView *promotionView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic)  YJAutoScrollerView *autoSV;
/*<#name#>*/
@property (strong, nonatomic) NSArray *promotionArr;
/*存放礼物说推荐图片地址*/
@property (strong, nonatomic) NSMutableArray *promotionImageUrlArr;
/*存放礼物说推荐标题地址*/
@property (strong, nonatomic) NSMutableArray *promotionTitleArr;
/*<#name#>*/
@property (strong, nonatomic) NSMutableArray *prmotionTitleColorArr;
/*存放礼物说推荐图片data*/
@property (strong, nonatomic) NSArray *promotionDataArr;
@end
@implementation YJAutoCell

- (NSMutableArray *)promotionImageUrlArr{
    if (!_promotionImageUrlArr) {
        _promotionImageUrlArr = [NSMutableArray array];
    }
    return _promotionImageUrlArr;
}
- (NSMutableArray *)promotionTitleArr{
    if (!_promotionTitleArr) {
        _promotionTitleArr = [NSMutableArray array];
    }
    return _promotionTitleArr;
}
- (NSMutableArray *)prmotionTitleColorArr{
    if (!_prmotionTitleColorArr) {
        _prmotionTitleColorArr = [NSMutableArray array];
    }
    return _prmotionTitleColorArr;
}
- (void)setBannerImageUrlArr:(NSMutableArray *)bannerImageUrlArr{
    _bannerImageUrlArr = bannerImageUrlArr;
    
    YJAutoScrollerView *autoSV = [[YJAutoScrollerView alloc]initWithFrame:CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    self.autoSV = autoSV;

    NSMutableArray *imageArr = [NSMutableArray array];
    
    for (int i = 0; i < self.bannerImageUrlArr.count; i++) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager GET:self.bannerImageUrlArr[i] parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.image = [UIImage imageWithData:responseObject];
            [imageArr addObject:imageView];
            
            if (imageArr.count == self.bannerImageUrlArr.count) {
                autoSV.imageViewAry = imageArr;
                [self.scrollView addSubview:autoSV];
                [autoSV shouldAutoShow:YES];
            }
            
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            NSLog(@"请求数据失败");
        }];
    }
}
- (void)awakeFromNib {
   
}

#pragma mark 当前控制器消失时取消定时器
- (void)viewDidDisappear:(BOOL)animated{
    [self.autoSV shouldAutoShow:NO];
}
- (void)viewDidAppear:(BOOL)animated{
    [self.autoSV shouldAutoShow:YES];
}
#pragma mark 获取promotion图片地址和标题
- (void)getPromotionsImageUrlAFNetwork{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:@"http://api.liwushuo.com/v2/promotions?gender=1&generation=1" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        self.promotionArr = responseObject[@"data"][@"promotions"];
        
        for (int i = 0; i < self.promotionArr.count; i++) {
            [self.promotionImageUrlArr addObject:self.promotionArr[i][@"icon_url"]];
            [self.promotionTitleArr addObject:self.promotionArr[i][@"title"]];
            [self.prmotionTitleColorArr addObject:self.promotionArr[i][@"color"]];
        }
        
        if (self.promotionTitleArr.count == self.promotionArr.count && self.promotionImageUrlArr.count == self.promotionArr.count) {
            
            [self getPromotionsImageDataAFNetwork];
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

- (void)getPromotionsImageDataAFNetwork{

    NSMutableArray *dataArr = [NSMutableArray array];
    for (int i = 0; i < self.promotionImageUrlArr.count; i++) {
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager GET:self.promotionImageUrlArr[i] parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            [dataArr addObject:responseObject];

            if (dataArr.count == self.promotionImageUrlArr.count) {
                self.promotionDataArr = dataArr;
         
                [self setUpPromotionBtn];
            }
            
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            
        }];
    }
}

- (void)setUpPromotionBtn{
    
    static int i = 0;
        for (YJQuickLoginButton *btn in self.promotionView.subviews) {
            
            UIImage *image = [UIImage imageWithData:self.promotionDataArr[i]];
            image = [UIImage OriginImage:image scaleToSize:CGSizeMake(40, 40)];
            [btn setImage:image forState:(UIControlStateNormal)];
            
            NSMutableDictionary *titleDict = [NSMutableDictionary dictionary];
            titleDict[NSFontAttributeName] = [UIFont systemFontOfSize:13];
            titleDict[NSForegroundColorAttributeName] = [UIColor colorWithHexString:self.prmotionTitleColorArr[i]];
            NSAttributedString *attString = [[NSAttributedString alloc]initWithString:self.promotionTitleArr[i] attributes:titleDict];
            [btn setAttributedTitle:attString forState:(UIControlStateNormal)];
            
            i++;
        }
}

+ (NSString *)ID{
    return @"autoCell";
}

+ (YJAutoCell *)autoCell{
    return [[NSBundle mainBundle]loadNibNamed:@"YJAutoCell" owner:nil options:nil][0];
}

@end
