//
//  YJCellController.m
//  Gifts
//
//  Created by yjadair on 15/11/11.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJCellController.h"
#import "UIButton+YJExpansion.h"
@interface YJCellController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIView *tabBarView;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

@end

@implementation YJCellController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.navigationItem.title = @"攻略详情";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageOriginImage:@"back.png"] Target:self Action:@selector(goBackToGiftView) Title:@"礼物说"];
   
    NSURL *url = [NSURL URLWithString:self.cellContentUrlArr[self.choiceIndex]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [self.webView loadRequest:request];
   
    [self setBtnOfTabBarView];
    
}

- (void)setBtnOfTabBarView{
    
    [self.likeBtn setBtnWithNorImage:[UIImage imageOriginImage:@"content-details_like"] SelImage:[UIImage imageOriginImage:@"content-details_like_selected"] TitleColor:[UIColor grayColor] Title:[self.cellLikeCountArr[self.choiceIndex] stringValue]];
}


- (void)goBackToGiftView{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
