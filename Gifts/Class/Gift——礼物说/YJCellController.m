//
//  YJCellController.m
//  Gifts
//
//  Created by yjadair on 15/11/11.
//  Copyright © 2015年 yjadair. All rights reserved.
///Users/yjadair/Desktop/Gifts/Gifts/Class/Gift——礼物说/view/YJChoicensCell.m
#define YJselectH 64
#define YJheaderH 200
#define YJheaderMinH 0
#import "YJCellController.h"
#import "UIButton+YJExpansion.h"
#import "YJGiftCellDetail.h"
#import <UIImageView+WebCache.h>
@interface YJCellController ()<UIScrollViewDelegate, UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIView *tabBarView;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *headLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tabBarHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redViewBottom;

@end

@implementation YJCellController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.webView.scrollView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    self.navigationItem.title = @"攻略详情";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageOriginImage:@"back.png"] Target:self Action:@selector(goBackToGiftView) Title:@"礼物说"];
    
    self.webView.scrollView.delegate = self;
    self.webView.delegate = self;
    
    NSURL *url = [NSURL URLWithString:self.giftCellDetail.content_url];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [self.webView loadRequest:request];
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:self.giftCellDetail.cover_image_url]];
    self.headLabel.text = self.giftCellDetail.title;
    [self.likeBtn setBtnWithNorImage:[UIImage imageOriginImage:@"content-details_like"] SelImage:[UIImage imageOriginImage:@"content-details_like_selected"] TitleColor:[UIColor grayColor] Title:[NSString stringWithFormat:@"%d", self.giftCellDetail.likes_count]];
}
//webView加载完毕后调用
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //获得weiView的实际内容高度
    NSString  *htmlHeight = [self.webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"];
    NSLog(@"%@", htmlHeight);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.y;
    if (offset > 0) {
        offset = 0;
    }
    self.headConstraint.constant = - offset;
}
- (void)goBackToGiftView{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
