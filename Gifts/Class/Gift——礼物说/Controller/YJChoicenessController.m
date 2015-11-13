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

#import "YJAutoCell.h"
#define kCount 4

@interface YJChoicenessController()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *itemsTableView;
/*<#name#>*/
@property (strong, nonatomic) NSArray *bannersArr;

/*<#name#>*/
@property (strong, nonatomic) NSArray *tempItemsData;
/*<#name#>*/
@property (strong, nonatomic) NSArray *itemsDataArr;
/*<#name#>*/
@property (strong, nonatomic) NSMutableArray *itemsArr;

/*<#name#>*/
@property (strong, nonatomic) NSMutableArray *cellContentUrlArr;
/*<#name#>*/
@property (strong, nonatomic) NSMutableArray *cellLikeCountArr;

/*<#name#>*/
@property (strong, nonatomic) NSMutableArray *tempBannerImageUrlArr;
@end
@implementation YJChoicenessController

- (NSMutableArray *)tempBannerImageUrlArr{
    if (!_tempBannerImageUrlArr) {
        _tempBannerImageUrlArr = [NSMutableArray array];
    }
    return _tempBannerImageUrlArr;
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
- (NSMutableArray *)cellLikeCountArr{
    if (!_cellLikeCountArr) {
        _cellLikeCountArr = [NSMutableArray array];
    }
    return _cellLikeCountArr;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    [self getBannerImageUrlAFNetwork];
    [self getTempItemsData];
  
}
#pragma mark 获取广告图片地址
- (void)getBannerImageUrlAFNetwork{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:@"http://api.liwushuo.com/v2/banners?channel=iOS" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        self.bannersArr = responseObject[@"data"][@"banners"];

        for (int i = 0; i < self.bannersArr.count; i++) {
            [self.tempBannerImageUrlArr addObject:self.bannersArr[i][@"image_url"]];
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
    
}

#pragma mark 获取cell的信息
- (void)getTempItemsData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:@"http://api.liwushuo.com/v2/channels/100/items?ad=1&gender=1&generation=1&limit=20&offset=0" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
       self.tempItemsData = responseObject[@"data"][@"items"];
        
        for (int i = 0; i < self.tempItemsData.count; i++) {
            [self.cellContentUrlArr addObject:self.tempItemsData[i][@"content_url"]];
            [self.cellLikeCountArr addObject:self.tempItemsData[i][@"likes_count"]];
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
    if (indexPat.row == 0) {

        YJAutoCell *itemCell = [tableView dequeueReusableCellWithIdentifier:[YJAutoCell ID]];
        if (!itemCell) {
            itemCell = [YJAutoCell autoCell];
        }
        [itemCell getPromotionsImageUrlAFNetwork];
       itemCell.bannerImageUrlArr = self.tempBannerImageUrlArr;
        return itemCell;
    }else{
        YJChoicensCell *itemCell = [tableView dequeueReusableCellWithIdentifier:[YJChoicensCell ID]];
        if (!itemCell) {
            itemCell = [YJChoicensCell choicensCell];
        }
        YJChoicenRowItem *rowItem = self.itemsArr[indexPat.row];
        itemCell.itemCell = rowItem;
        return itemCell;
    }
   
}
#pragma mark 设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    if (indexPat.row == 0) {
        return 230;
    }else{
        
        YJChoicensCell *choicensCell = [YJChoicensCell choicensCell];
        return choicensCell.cellHeight;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YJCellController *cellController = [[YJCellController alloc] init];
    cellController.cellContentUrlArr = self.cellContentUrlArr;
    cellController.cellLikeCountArr = self.cellLikeCountArr;
    cellController.choiceIndex = indexPath.row;
    cellController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cellController animated:YES];
}

@end
