//
//  YJChoicenessController.m
//  Gifts
//
//  Created by yjadair on 15/11/10.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJChoicenessController.h"
#import "YJAutoScrollerView.h"
#import "YJQuickLoginButton.h"
#import "YJChoicenRowItem.h"
#import "YJChoicensCell.h"
#import "YJCellController.h"
#define kCount 4

@interface YJChoicenessController()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *itemsTableView;

@property (weak, nonatomic) IBOutlet UIView *promotionView;
@property (weak, nonatomic) IBOutlet UIView *scrollView;
@property (weak, nonatomic)  YJAutoScrollerView *autoSV;
/*<#name#>*/
@property (strong, nonatomic) NSArray *bannersArr;
/*<#name#>*/
@property (strong, nonatomic) NSArray *promotionArr;
/*存放礼物说广告图片地址*/
@property (strong, nonatomic) NSMutableArray *bannerImageUrlArr;
/*存放礼物说推荐图片地址*/
@property (strong, nonatomic) NSMutableArray *promotionImageUrlArr;
/*存放礼物说推荐标题地址*/
@property (strong, nonatomic) NSMutableArray *promotionTitleArr;
/*<#name#>*/
@property (strong, nonatomic) NSMutableArray *prmotionTitleColorArr;
/*存放礼物说推荐图片data*/
@property (strong, nonatomic) NSArray *promotionDataArr;

/*<#name#>*/
@property (strong, nonatomic) NSArray *tempItemsData;
/*<#name#>*/
@property (strong, nonatomic) NSArray *itemsDataArr;
/*<#name#>*/
@property (strong, nonatomic) NSMutableArray *itemsArr;

/*<#name#>*/
@property (strong, nonatomic) NSMutableArray *cellContentUrlArr;
@end
@implementation YJChoicenessController
- (NSMutableArray *)bannerImageUrlArr{
    if (!_bannerImageUrlArr) {
        _bannerImageUrlArr = [NSMutableArray array];
    }
    return _bannerImageUrlArr;
}
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
- (NSMutableArray *)itemsArr{
    if (!_itemsArr) {
        _itemsArr = [NSMutableArray array];
    }
    return _itemsArr;
}
- (NSMutableArray *)cellContentUrlArr{
    if (!_cellContentUrlArr) {
        _cellContentUrlArr = [NSMutableArray array];
    }
    return _cellContentUrlArr;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    [self getBannerImageUrlAFNetwork];
    [self getPromotionsImageUrlAFNetwork];
    [self getTempItemsData];
  
}
#pragma mark 获取广告图片地址
- (void)getBannerImageUrlAFNetwork{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:@"http://api.liwushuo.com/v2/banners?channel=iOS" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        self.bannersArr = responseObject[@"data"][@"banners"];
        
        for (int i = 0; i < self.bannersArr.count; i++) {
            [self.bannerImageUrlArr addObject:self.bannersArr[i][@"image_url"]];
        }
       
        if (self.bannerImageUrlArr.count == self.bannersArr.count) {
            [self addAutoSV];
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
    
}
#pragma mark 自动广告
- (void)addAutoSV{
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
        
    }];
    }
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
    for (UIButton *btn in self.promotionView.subviews) {
       
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

#pragma mark 获取cell的信息
- (void)getTempItemsData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:@"http://api.liwushuo.com/v2/channels/100/items?ad=1&gender=1&generation=1&limit=20&offset=0" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
       self.tempItemsData = responseObject[@"data"][@"items"];
        
        for (int i = 0; i < self.tempItemsData.count; i++) {
            [self.cellContentUrlArr addObject:self.tempItemsData[i][@"content_url"]];
        }
        [self getItemsData];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}
#pragma mark 获取图片的Data
- (void)getItemsData{
    NSMutableArray *itemsDataArr = [NSMutableArray array];
    for (int i = 0; i < self.tempItemsData.count; i++) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager GET:self.tempItemsData[i][@"cover_image_url"] parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            [itemsDataArr addObject:responseObject];
            if (itemsDataArr.count == self.tempItemsData.count) {
                self.itemsDataArr = itemsDataArr;
                [self setUpItems];
            }
            
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            
        }];
    }
}
#pragma mark 设置cell
- (void)setUpItems{
 
    for (int i = 0; i < self.itemsDataArr.count; i++) {
        
        YJChoicenRowItem *rowItem = [[YJChoicenRowItem alloc]init];
        rowItem.imageData = self.itemsDataArr[i];
        rowItem.title = self.tempItemsData[i][@"title"];
        rowItem.likeCount = self.tempItemsData[i][@"likes_count"];
        [self.itemsArr addObject:rowItem];
        
    }
   [self.itemsTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return self.itemsArr.count;
}
#pragma mark 创建Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPat{
    static NSString *ID = @"itemCell";
    YJChoicensCell *itemCell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!itemCell) {
        itemCell = [YJChoicensCell choicensCell];
    }
    YJChoicenRowItem *rowItem = self.itemsArr[indexPat.row];
    itemCell.itemCell = rowItem;
    return itemCell;
}
#pragma mark 设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YJChoicensCell *choicensCell = [YJChoicensCell choicensCell];
    return choicensCell.cellHeight;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YJCellController *cellController = [[YJCellController alloc] init];
    cellController.cellContentUrlArr = self.cellContentUrlArr;
    cellController.choiceIndex = indexPath.row;
    
    [self.navigationController pushViewController:cellController animated:YES];
    
}
@end
