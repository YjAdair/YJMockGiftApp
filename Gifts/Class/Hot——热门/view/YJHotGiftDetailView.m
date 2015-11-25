//
//  YJHotGiftDetailCell.m
//  Gifts
//
//  Created by yjadair on 15/11/18.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJHotGiftDetailView.h"
#import "YJHotGiftComment.h"
#import "YJHotGiftCommentCell.h"
@interface YJHotGiftDetailView()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *sliderView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (weak, nonatomic) IBOutlet UIButton *pictureBtn;
@property (weak, nonatomic) IBOutlet UIButton *judgeBtn;
/*<#name#>*/
@property (weak, nonatomic) UIWebView *webView;
/*<#name#>*/
@property (weak, nonatomic) UITableView *tableView;
/*<#name#>*/
@property (strong, nonatomic) NSArray *commentDetailArr;
/*<#name#>*/
@property (strong, nonatomic) AFHTTPRequestOperationManager *manager;
@end

@implementation YJHotGiftDetailView

- (AFHTTPRequestOperationManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPRequestOperationManager manager];
    }
    return _manager;
}

- (void)awakeFromNib{
    
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;

    self.contentScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 2, 0);
    [self setupWebView];
    [self setupTableView];
}

- (void)setPictureHtmlDetailUrl:(NSString *)pictureHtmlDetailUrl{
    _pictureHtmlDetailUrl = pictureHtmlDetailUrl;

    [self.manager GET:pictureHtmlDetailUrl parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSString *fullPath = [filePath stringByAppendingPathComponent:@"hotGiftDetailImages.html"];
        NSString *htmlContent = responseObject[@"data"][@"detail_html"];
        [htmlContent writeToFile:fullPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        NSURL *url = [NSURL URLWithString:fullPath];
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
}

- (void)setCommentUrl:(NSString *)commentUrl{
    _commentUrl = commentUrl;

    [self.manager GET:commentUrl parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSMutableArray *commentArr = [NSMutableArray array];
        NSArray *tempCommtentArr = responseObject[@"data"][@"comments"];
        for (int i = 0; i < tempCommtentArr.count; i++) {
            YJHotGiftComment *comment = [YJHotGiftComment mj_objectWithKeyValues:tempCommtentArr[i]];
            [commentArr addObject:comment];
            
        }
        self.commentDetailArr = commentArr;
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
}

- (void)setupWebView{
    
    UIWebView *webView = [[UIWebView alloc]init];
    self.webView = webView;
    webView.frame = [UIScreen mainScreen].bounds;
    webView.yj_width = [UIScreen mainScreen].bounds.size.width;
    webView.yj_height = self.contentScrollView.yj_height;
    webView.scrollView.backgroundColor = [UIColor redColor];
    [self.contentScrollView addSubview:webView];

    
}

- (void)setupTableView{
    
    UITableView *tableView = [[UITableView alloc]init];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.frame = [UIScreen mainScreen].bounds;
    tableView.yj_x = [UIScreen mainScreen].bounds.size.width;
    tableView.yj_height = self.contentScrollView.yj_height;
    
    [self.contentScrollView addSubview:tableView];
    
    [tableView registerNib:[UINib nibWithNibName:@"YJHotGiftCommentCell" bundle:nil] forCellReuseIdentifier:[YJHotGiftCommentCell ID]];
}

- (IBAction)changeViewShow:(UIButton *)sender {
    
    [UIView animateWithDuration:0.25 animations:^{
        self.sliderView.yj_centerX = sender.tag == 1? self.pictureBtn.yj_centerX : self.judgeBtn.yj_centerX;
    }];
    
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = sender.tag == 1? 0 : [UIScreen mainScreen].bounds.size.width;
    [self.contentScrollView setContentOffset:offset animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.commentDetailArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YJHotGiftCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:[YJHotGiftCommentCell ID]];
    YJHotGiftComment *comment = self.commentDetailArr[indexPath.row];
    
    cell.headIconUrl = comment.user.avatar_url;
    cell.UserNames = comment.user.nickname;
    cell.contents = comment.content;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    YJHotGiftCommentCell *commentCell = [YJHotGiftCommentCell commentCell];
    return commentCell.cellHeight;
}
@end
