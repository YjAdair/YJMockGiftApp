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
@interface YJHotGiftDetailController ()<YJHotAutoCellDelegate, UITableViewDataSource,UITableViewDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *contentTableView;

/*<#name#>*/
@property (strong, nonatomic) NSURL *url;
@end

@implementation YJHotGiftDetailController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.contentTableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.contentTableView registerNib:[UINib nibWithNibName:@"YJHotAutoCell" bundle:nil] forCellReuseIdentifier:[YJHotAutoCell ID]];
    
    [self setupFooterView];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageOriginImage:@"back.png"] Target:self Action:@selector(goBackToGiftView) Title:@"热门 "];

}

- (void)goBackToGiftView{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupFooterView{

    YJHotGiftDetailView *hotGiftDetailView = [[NSBundle mainBundle]loadNibNamed:@"YJHotGiftDetailView" owner:nil options:nil][0];
    
    hotGiftDetailView.frame = self.view.bounds;
    hotGiftDetailView.pictureHtmlDetailUrl = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/items/%@?", self.giftDetailID];
    hotGiftDetailView.commentUrl = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/items/%@/comments?limit=20&offset=0", self.giftDetailID];
    
    self.contentTableView.tableFooterView = hotGiftDetailView;
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

    [self.contentTableView reloadData];
}

- (IBAction)jump:(id)sender {
    
    NSString *itemId = @"524041453644";

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"taobao://item.taobao.com/item.htm?id=%@", itemId]];
    self.url = url;
    // 判断当前系统是否有安装淘宝客户端
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否打开‘淘宝’" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"打开", nil];
        alert.delegate = self;
        [alert show];
        // 如果已经安装淘宝客户端，就使用客户端打开链接
        
        
    } else {
        // 否则使用 Mobile Safari 或者内嵌 WebView 来显示
        
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://item.taobao.com/item.htm?id=%@", itemId ]];
        
        [[UIApplication sharedApplication] openURL:url];
        NSLog(@"打开safari");
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:self.url];
        NSLog(@"打开淘宝客户端");

    }
}
@end
