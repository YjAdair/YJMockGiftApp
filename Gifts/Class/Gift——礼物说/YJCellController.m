//
//  YJCellController.m
//  Gifts
//
//  Created by yjadair on 15/11/11.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJCellController.h"

@interface YJCellController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation YJCellController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"攻略详情";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageOriginImage:@"back.png"] Target:self Action:@selector(goBackToGiftView) Title:@"礼物说"];
   
    NSURL *url = [NSURL URLWithString:self.cellContentUrlArr[self.choiceIndex]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [self.webView loadRequest:request];
    
}

- (void)goBackToGiftView{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
