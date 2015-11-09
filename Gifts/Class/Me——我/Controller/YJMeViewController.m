//
//  YJMeViewController.m
//  Gifts
//
//  Created by yjadair on 15/11/8.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJMeViewController.h"
#import "YJQuickLoginButton.h"
#import "YJLikeViewCell.h"
#import "YJNormalViewCell.h"

#import "YJMeRowCell.h"
#import "YJMeSectionCell.h"
#define YJselectH 44
#define YJheaderH 200
#define YJheaderMinH 64
@interface YJMeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headConstaint;
@property (assign, nonatomic) CGFloat originY;
/*<#name#>*/
@property (strong, nonatomic) NSMutableArray *cellItem;
@end

@implementation YJMeViewController

- (NSMutableArray *)cellItem{
    if (!_cellItem) {
        _cellItem = [NSMutableArray array];
        NSMutableArray *arr0 = [NSMutableArray array];
        NSMutableArray *arr1 = [NSMutableArray array];
        YJMeRowCell *sec0row1 = [[YJMeRowCell alloc]init];
        sec0row1.title = @"我的积分";
        sec0row1.image = [UIImage imageNamed:@"Me_credit"];
        [arr0 addObject:sec0row1];
        
        YJMeRowCell *sec0row2 = [[YJMeRowCell alloc]init];
        sec0row2.title = @"我的订单";
        sec0row2.image = [UIImage imageNamed:@"Me_taobaoOrder"];
        [arr0 addObject:sec0row2];
        
        YJMeRowCell *sec0row3 = [[YJMeRowCell alloc]init];
        sec0row3.title = @"我的礼券";
        sec0row3.image = [UIImage imageNamed:@"Me_coupon"];
        [arr0 addObject:sec0row3];
        YJMeSectionCell *secCell1 = [[YJMeSectionCell alloc]init];
        secCell1.secArr = arr0;
        [_cellItem addObject:secCell1];
        
        YJMeRowCell *sec1row0 = [[YJMeRowCell alloc]init];
        [arr1 addObject:sec1row0];
        YJMeSectionCell *secCell2 = [[YJMeSectionCell alloc]init];
        secCell2.secArr = arr1;
        [_cellItem addObject:secCell2];
    }
    return _cellItem;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:(UIBarMetricsDefault)];
    self.view.backgroundColor = [UIColor redColor];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithNorImage:[UIImage OriginImage:[UIImage imageNamed:@"Me_Settings"] scaleToSize:CGSizeMake(22, 22)] Target:self Action:@selector(setting)];
    
    UIBarButtonItem *messageItem = [UIBarButtonItem itemWithImage:[UIImage OriginImage:[UIImage imageNamed:@"Me_GiftMessage"] scaleToSize:CGSizeMake(22, 22)] Target:self Action:@selector(message)];
    UIBarButtonItem *remindItem = [UIBarButtonItem itemWithImage:[UIImage OriginImage:[UIImage imageNamed:@"Me_GiftRemind"] scaleToSize:CGSizeMake(22, 22)] Target:self Action:@selector(remind)];
    
    self.navigationItem.leftBarButtonItems = @[messageItem, remindItem];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
}
- (void)setting{
    YJNslogFunc
}
- (void)message{
    YJNslogFunc
}
- (void)remind{
    YJNslogFunc
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat currentY = scrollView.contentOffset.y;
////    CGFloat offset = currentY;
    NSLog(@"currentY = %lf", currentY);
//    CGFloat h = YJheaderH - currentY;
////    NSLog(@"h = %lf", h);
//    if (h < YJheaderMinH) {
//        h = YJheaderMinH;
//    }
//    _headConstaint.constant = h;

    
//    if (h > 180) {
//        _loginTop.constant = 78 - 78 * (offset / 200);
//        _loginH.constant = 66 * (1 - offset/200);
//        _loginW.constant = _loginH.constant;
//    }else if (h <= 180&&h > 146){
//        _loginH.constant = 59;
//        _loginW.constant = _loginH.constant;
//        _loginTop.constant = 71;
//    }else if (h <= 146 && h > 64){
//         _loginTop.constant = 71 - 71 * (offset - 49 / 148);
//    }else if (h == 64){
//        _loginTop.constant = 20;
//    } 
//    NSLog(@"%lf", _loginW.constant);
//     NSLog(@"%lf", _loginTop.constant);
//    NSLog(@"%lf", h);
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   
    return self.cellItem.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    YJMeSectionCell *secCell = self.cellItem[section];
    return secCell.secArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        YJNormalViewCell *norCell = [tableView dequeueReusableCellWithIdentifier:[YJNormalViewCell ID]];
        if (!norCell) {
            norCell = [YJNormalViewCell normalCell];
        }
        YJMeSectionCell *secCell = self.cellItem[indexPath.section];
        YJMeRowCell *rowCell = secCell.secArr[indexPath.row];
        norCell.rowCell = rowCell;
        return norCell;
    }else{
        YJLikeViewCell *likeCell = [tableView dequeueReusableCellWithIdentifier:[YJLikeViewCell ID]];
        if (!likeCell) {
            likeCell = [YJLikeViewCell likemCell];
        }
        YJMeSectionCell *secCell = self.cellItem[indexPath.section];
        YJMeRowCell *rowCell = secCell.secArr[indexPath.row];
        likeCell.rowCell = rowCell;
        return likeCell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 20;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        YJLikeViewCell *likeCell = [YJLikeViewCell likemCell];
        return likeCell.likeCellH;
    }else{
        return 44;
    }
}
@end
