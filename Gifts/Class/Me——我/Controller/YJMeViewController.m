//
//  YJMeViewController.m
//  Gifts
//
//  Created by yjadair on 15/11/8.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJMeViewController.h"
#import "YJQuickLoginButton.h"
#define YJselectH 44
#define YJheaderH 200
#define YJheaderMinH 64
@interface YJMeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headConstaint;
@property (assign, nonatomic) CGFloat originY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginTop;

@end

@implementation YJMeViewController

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
    self.automaticallyAdjustsScrollViewInsets = NO;
    _originY = -(YJheaderH + YJselectH);
    self.tableView.contentInset = UIEdgeInsetsMake(YJheaderH + YJselectH, 0, 0, 0);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@", NSStringFromCGPoint(self.tableView.contentOffset));
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
    CGFloat offset = currentY - _originY;
    NSLog(@"offset = %lf", offset);
    CGFloat h = YJheaderH - offset;
//    NSLog(@"h = %lf", h);
    if (h < YJheaderMinH) {
        h = YJheaderMinH;
    }
    _headConstaint.constant = h;
    
    if (h > 140) {
        _loginTop.constant = 78 - 78 * (offset / 200);
        _loginH.constant = 66 - offset / 2;
        _loginW.constant = 66 - offset / 2;
    }else if (h <= 140&&h>64){
        _loginH.constant = 37;
        _loginW.constant = 37;
        _loginTop.constant = 78 - 78 * (offset / 200);
    }else if (h == 64){
        _loginTop.constant = 24;
    }
    NSLog(@"%lf", _loginTop.constant);
    NSLog(@"%lf", h);
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];

    return cell;
}
@end
