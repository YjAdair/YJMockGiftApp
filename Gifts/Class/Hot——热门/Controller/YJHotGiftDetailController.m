//
//  YJHotGiftDetailController.m
//  Gifts
//
//  Created by yjadair on 15/11/13.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJHotGiftDetailController.h"
#import "YJHotAutoCell.h"
#import "YJHotGiftComment.h"
#import "YJHotGiftDetailView.h"
@interface YJHotGiftDetailController ()<YJHotAutoCellDelegate>
/*<#name#>*/
@property (weak, nonatomic) AFHTTPRequestOperationManager *manager;
@end

@implementation YJHotGiftDetailController
- (AFHTTPRequestOperationManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPRequestOperationManager manager];
    }
    return _manager;
}

- (instancetype)init{
    return [self initWithStyle:(UITableViewStyleGrouped)];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.manager GET:@"http://api.liwushuo.com/v2/items/1041675/comments?limit=20&offset=0" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSMutableArray *commentArr = [NSMutableArray array];
        NSArray *tempCommtentArr = responseObject[@"data"][@"comments"];
        for (int i = 0; i < tempCommtentArr.count; i++) {
            YJHotGiftComment *comment = [YJHotGiftComment mj_objectWithKeyValues:tempCommtentArr[i]];
            [commentArr addObject:comment];
        }
    
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"YJHotAutoCell" bundle:nil] forCellReuseIdentifier:[YJHotAutoCell ID]];
    
    
    YJHotGiftDetailView *hotGiftDetailView = [[NSBundle mainBundle]loadNibNamed:@"YJHotGiftDetailView" owner:nil options:nil][0];
    hotGiftDetailView.frame = self.view.bounds;
    hotGiftDetailView.pictureHtmlDetailUrl = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/items/%@?", self.giftDetailID];
   
    self.tableView.tableFooterView = hotGiftDetailView;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        YJHotAutoCell * cell = [tableView dequeueReusableCellWithIdentifier:[YJHotAutoCell ID]];
        cell.delegate = self;
        cell.hotGiftItemUrl = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/items/%@?", self.giftDetailID];
        return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    YJHotAutoCell *hotAutoCell = [YJHotAutoCell HotautoCell];
   
    return hotAutoCell.cellHeight;
}
- (void)hotAutoCell:(YJHotAutoCell *)hotAutoCell{
    [self.tableView reloadData];
}
@end
