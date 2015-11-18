//
//  YJHotGiftDetailCell.m
//  Gifts
//
//  Created by yjadair on 15/11/18.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJHotGiftDetailView.h"
@interface YJHotGiftDetailView()

@property (weak, nonatomic) IBOutlet UIView *sliderView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (weak, nonatomic) IBOutlet UIButton *pictureBtn;
@property (weak, nonatomic) IBOutlet UIButton *judgeBtn;
/*<#name#>*/
@property (weak, nonatomic) UIWebView *webView;
/*<#name#>*/
@property (weak, nonatomic) AFHTTPRequestOperationManager *manager;
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

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:pictureHtmlDetailUrl parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
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
    UITableView *tableVeiw = [[UITableView alloc]init];
    tableVeiw.frame = [UIScreen mainScreen].bounds;
    tableVeiw.yj_x = [UIScreen mainScreen].bounds.size.width;
    tableVeiw.yj_height = self.contentScrollView.yj_height;
    tableVeiw.backgroundColor = [UIColor orangeColor];
    [self.contentScrollView addSubview:tableVeiw];
    
   
}
- (IBAction)changeViewShow:(UIButton *)sender {
    
    [UIView animateWithDuration:0.25 animations:^{
        self.sliderView.yj_centerX = sender.tag == 1? self.pictureBtn.yj_centerX : self.judgeBtn.yj_centerX;
    }];
    
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = sender.tag == 1? 0 : [UIScreen mainScreen].bounds.size.width;
    [self.contentScrollView setContentOffset:offset animated:YES];
}
@end
