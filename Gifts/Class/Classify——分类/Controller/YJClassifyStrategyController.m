//
//  YJClassifyStrategyController.m
//  Gifts
//
//  Created by yjadair on 15/11/21.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJClassifyStrategyController.h"
#import "YJClassifyStrategySpecialCell.h"
#import "YJClassifyStrategyCell.h"
#import <MJExtension.h>
#import "YJStrategy.h"

@interface YJClassifyStrategyController()
/*<#name#>*/
@property (strong, nonatomic) AFHTTPSessionManager *manager;
/*<#name#>*/
@property (strong, nonatomic) NSMutableArray *strategyArr;
@end

@implementation YJClassifyStrategyController

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (NSMutableArray *)strategyArr{
    if (!_strategyArr) {
        _strategyArr = [NSMutableArray array];
    }
    return _strategyArr;
}
-(instancetype)init{
    return [self initWithStyle:(UITableViewStyleGrouped)];
}
- (void)viewDidLoad{
    
    [super viewDidLoad];
    [self setupTableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"YJClassifyStrategyCell" bundle:nil] forCellReuseIdentifier:[YJClassifyStrategyCell ID]];
    [self.tableView registerNib:[UINib nibWithNibName:@"YJClassifyStrategySpecialCell" bundle:nil] forCellReuseIdentifier:[YJClassifyStrategySpecialCell ID]];
    
    [self getClassifyChannelsInfo];
}
- (void)setupTableView{
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];

}

- (void)getClassifyChannelsInfo{
    
    [self.manager GET:@"http://api.liwushuo.com/v2/channel_groups/all?" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSArray *channelDataArr = responseObject[@"data"][@"channel_groups"];
        for (int i = 0; i < channelDataArr.count; i++) {
            [self.strategyArr addObject:[YJStrategy mj_objectWithKeyValues:channelDataArr[i]]];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else{

        return self.strategyArr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        YJClassifyStrategySpecialCell *specialCell = [tableView dequeueReusableCellWithIdentifier:[YJClassifyStrategySpecialCell ID]];
      
        return specialCell;
    }else{
        YJClassifyStrategyCell *strategyCell = [tableView dequeueReusableCellWithIdentifier:[YJClassifyStrategyCell ID]];
        YJStrategy *strategy = self.strategyArr[indexPath.row];
        strategyCell.strategy = strategy;
        return strategyCell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat
{
    if (indexPat.section == 0) {
        YJClassifyStrategySpecialCell *specialCell = [YJClassifyStrategySpecialCell specialCell];

        return specialCell.cellHeight;
    }else{
        YJStrategy *strategy = self.strategyArr[indexPat.row];
        return strategy.cellHeight;
    }
    
}
@end
