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
#import "YJGiftBanner.h"
#import "YJGiftCellDetail.h"
#define kCount 4
#define YJCellDetail  @"http://api.liwushuo.com/v2/channels/100/items?ad=1&gender=1&generation=1&limit=20&offset=0"
// 弱引用
#define XMGWeakSelf __weak typeof(self) weakSelf = self;
@interface YJChoicenessController()<UITableViewDataSource, UITableViewDelegate>
/** 请求管理者 */
@property (nonatomic, weak) AFHTTPSessionManager *manager;

/*<#name#>*/
@property (strong, nonatomic) NSMutableArray *cellContentUrlArr;
/*<#name#>*/
@property (strong, nonatomic) NSMutableArray *cellLikeCountArr;

/*<#name#>*/
@property (strong, nonatomic) NSMutableArray *giftCellDetailArr;

/*<#name#>*/
@property (strong, nonatomic) NSString *giftNextCellDetailUrl;
@end
@implementation YJChoicenessController

- (NSMutableArray *)giftCellDetailArr{
    if (!_giftCellDetailArr) {
        _giftCellDetailArr = [NSMutableArray array];
    }
    return _giftCellDetailArr;
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
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (instancetype)init{
    return [self initWithStyle:(UITableViewStyleGrouped)];
}
- (void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    [self setupRefresh];
}
#pragma mark -上下刷新
- (void)setupRefresh{
    
    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}
//下拉刷新
- (void)loadNewTopics{
    
    // 取消之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    // 发送请求
    XMGWeakSelf;
    [self.manager GET:YJCellDetail parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *ItemsData = responseObject[@"data"][@"items"];

        weakSelf.giftNextCellDetailUrl = responseObject[@"data"][@"paging"][@"next_url"];

        for (int i = 0; i < ItemsData.count; i++) {
            
            YJGiftCellDetail *cellDetail = [YJGiftCellDetail mj_objectWithKeyValues:ItemsData[i]];
            [weakSelf.giftCellDetailArr addObject:cellDetail];
            
        }
        // 结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
        weakSelf.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}
/**
 * 加载更多的帖子数据
 */
- (void)loadMoreTopics{
    
    // 取消之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];

    // 发送请求
    XMGWeakSelf;
    [self.manager GET:self.giftNextCellDetailUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *ItemsData = responseObject[@"data"][@"items"];
        weakSelf.giftNextCellDetailUrl = responseObject[@"data"][@"paging"][@"next_url"];
        for (int i = 0; i < ItemsData.count; i++) {
            
            YJGiftCellDetail *cellDetail = [YJGiftCellDetail mj_objectWithKeyValues:ItemsData[i]];
            [weakSelf.giftCellDetailArr addObject:cellDetail];
            
        }
        // 结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    if (section == 0) {
        return 1;
    }else{
        return self.giftCellDetailArr.count;
    }
    
}
#pragma mark 创建Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPat{
    if (indexPat.section == 0) {

        YJAutoCell *itemCell = [tableView dequeueReusableCellWithIdentifier:[YJAutoCell ID]];
        if (!itemCell) {
            itemCell = [YJAutoCell autoCell];
        }
        return itemCell;
    }else{
        YJChoicensCell *itemCell = [tableView dequeueReusableCellWithIdentifier:[YJChoicensCell ID]];
        if (!itemCell) {
            itemCell = [YJChoicensCell choicensCell];
        }
        itemCell.cellDetail = self.giftCellDetailArr[indexPat.row];
        
        return itemCell;
    }
   
}
#pragma mark 设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    if (indexPat.section == 0) {
        YJAutoCell *autoCell = [YJAutoCell autoCell];
        return autoCell.cellHeight;
    }else{
        YJChoicensCell *choicensCell = [YJChoicensCell choicensCell];
        return choicensCell.cellHeight;
    }
}
#pragma mark -选择cell时调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YJGiftCellDetail *cellDetail = self.giftCellDetailArr[indexPath.row];
    
    YJCellController *cellController = [[YJCellController alloc] init];
    cellController.giftCellDetail = cellDetail;
    cellController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cellController animated:YES];
}

@end
