//
//  YJChoicenessController.m
//  Gifts
//
//  Created by yjadair on 15/11/10.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJChoicenessController.h"
#import "YJChoicenRowItem.h"
#import "YJChoicensCell.h"
#import "YJCellController.h"
#import "YJAutoCell.h"
#import "NSString+YJExpansion.h"
#define YJCellDetail  @"http://api.liwushuo.com/v2/channels/100/items?ad=1&gender=1&generation=1&limit=20&offset=0"
// 弱引用
#define XMGWeakSelf __weak typeof(self) weakSelf = self;

@interface YJChoicenessController()<UITableViewDataSource, UITableViewDelegate>

/** 请求管理者 */
@property (nonatomic, weak) AFHTTPSessionManager *manager;
/*精选cell的like数量数组*/
@property (strong, nonatomic) NSMutableArray *cellLikeCountArr;
/*上拉刷新——精选cell下批模型数组*/
@property (strong, nonatomic) NSString *giftNextCellDetailUrl;
/*保存每天的主题的数组*/
@property (strong, nonatomic) NSMutableArray<NSMutableArray *> *everydayCellGroupDate;

/*<#name#>*/
@property (strong, nonatomic) NSMutableArray<YJGiftCellDetail *> *cellGroup;
/*<#name#>*/
@property (strong, nonatomic)  NSString *tempDate;
@end
@implementation YJChoicenessController

- (NSMutableArray *)cellLikeCountArr{
    if (!_cellLikeCountArr) {
        _cellLikeCountArr = [NSMutableArray array];
    }
    return _cellLikeCountArr;
}
- (NSMutableArray *)everydayCellGroupDate{
    if (!_everydayCellGroupDate) {
        _everydayCellGroupDate = [NSMutableArray array];
    }
    return _everydayCellGroupDate;
}
- (NSMutableArray *)cellGroup{
    if (!_cellGroup) {
        _cellGroup = [NSMutableArray array];
    }
    return _cellGroup;
}
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark -设置tableView的类型
- (instancetype)init{
    return [self initWithStyle:(UITableViewStyleGrouped)];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    [self setupRefresh];
}
#pragma mark - 设置上下刷新
- (void)setupRefresh{

    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

#pragma mark - 下拉刷新
- (void)loadNewTopics{
    
    // 取消之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    // 发送请求
    XMGWeakSelf;
    [self.manager GET:YJCellDetail parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *ItemsData = responseObject[@"data"][@"items"];

        weakSelf.giftNextCellDetailUrl = responseObject[@"data"][@"paging"][@"next_url"];

        NSString *tempDate = [NSString string];
     
        for (int i = 0; i < ItemsData.count; i++) {
            
            YJGiftCellDetail *cellDetail = [YJGiftCellDetail mj_objectWithKeyValues:ItemsData[i]];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            formatter.dateFormat = @"MM月dd日 ";
            NSTimeInterval time = cellDetail.published_at.longLongValue;
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
            NSString *publishDate = [formatter stringFromDate:date];

            /*
             当前时间与上次时间不同就创建一个数组A，将模型存到数组A中，并创建以全局数组指针B指向新创建出来的数组，最后将数组A(B)保存到大数组C中
             当前时间以上次时间相同就保存到之前创建出来的数组A（B）中
             */
            if (![publishDate isEqualToString:tempDate]) {
                NSMutableArray *dateGoup = [NSMutableArray array];
                weakSelf.cellGroup = dateGoup;
                cellDetail.isShowTime = YES;
                [dateGoup addObject:cellDetail];
                [weakSelf.everydayCellGroupDate addObject:dateGoup];
                
            }else{
                cellDetail.isShowTime = NO;
                [weakSelf.cellGroup addObject:cellDetail];
            }
            tempDate = publishDate;
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


#pragma mark - 上拉刷新
- (void)loadMoreTopics{
    
    // 取消之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];

    // 发送请求
    XMGWeakSelf;
    [self.manager GET:self.giftNextCellDetailUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *ItemsData = responseObject[@"data"][@"items"];
        
        weakSelf.giftNextCellDetailUrl = responseObject[@"data"][@"paging"][@"next_url"];

        NSString *tempDate = [NSString string];
        for (int i = 0; i < ItemsData.count; i++) {
            
            YJGiftCellDetail *cellDetail = [YJGiftCellDetail mj_objectWithKeyValues:ItemsData[i]];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            formatter.dateFormat = @"MM月dd日 ";
            NSTimeInterval time = cellDetail.published_at.longLongValue;
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
            NSString *publishDate = [formatter stringFromDate:date];
            
            /*
             当前时间与上次时间不同就创建一个数组A，将模型存到数组A中，并创建以全局数组指针B指向新创建出来的数组，最后将数组A(B)保存到大数组C中
             当前时间以上次时间相同就保存到之前创建出来的数组A（B）中
             */
            if (![publishDate isEqualToString:tempDate]) {
                NSMutableArray *dateGoup = [NSMutableArray array];
                weakSelf.cellGroup = dateGoup;
                cellDetail.isShowTime = YES;
                [dateGoup addObject:cellDetail];
                [weakSelf.everydayCellGroupDate addObject:dateGoup];
                
            }else{
                cellDetail.isShowTime = NO;
                [weakSelf.cellGroup addObject:cellDetail];
            }
            tempDate = publishDate;
        }
        // 结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

#pragma makr - UITableViewDataSoure
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.everydayCellGroupDate.count + 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        return 1;
    }else{
        return self.everydayCellGroupDate[section - 1].count;
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

        YJGiftCellDetail *cellDetail = self.everydayCellGroupDate[indexPat.section -1][indexPat.row];
        itemCell.cellDetail = cellDetail;
        
        return itemCell;
    }
   
}
#pragma mark -UITableViewDelegate
#pragma mark 设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    if (indexPat.section == 0) {
        YJAutoCell *autoCell = [YJAutoCell autoCell];
        return autoCell.cellHeight;
    }else{
        YJChoicensCell *choicensCell = [YJChoicensCell choicensCell];
        if (!choicensCell.cellDetail.isShowTime) {
            return choicensCell.cellHeight - 30;
        }else{
            return choicensCell.cellHeight;
        }
    }
  
}
#pragma mark -选择cell时调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YJGiftCellDetail *cellDetail = self.everydayCellGroupDate[indexPath.section - 1][indexPath.row];
   
    //Push cell详情控制器
    YJCellController *cellController = [[YJCellController alloc] init];
    cellController.giftCellDetail = cellDetail;
    cellController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cellController animated:YES];
}



@end
