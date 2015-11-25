//
//  YJClassifyStrategyCell.m
//  Gifts
//
//  Created by yjadair on 15/11/21.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJClassifyStrategyCell.h"
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
#import "YJStrategy.h"
#import "YJChannel.h"
#import "YJChannelBtn.h"
@interface YJClassifyStrategyCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/*<#name#>*/
@property (weak, nonatomic) UIView *view;
/*<#name#>*/
@property (strong, nonatomic) AFHTTPSessionManager *manager;
@end
@implementation YJClassifyStrategyCell
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)setStrategy:(YJStrategy *)strategy{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _strategy = strategy;
    
    self.titleLabel.text = strategy.name;
    
    [self addChannels:strategy];
    
}

- (void)addChannels:(YJStrategy *)strategy{
    
    UIView *view = [[UIView alloc]init];
    self.view = view;
    view.yj_x = 10;
    view.yj_y = 41.5;
    view.yj_width = [UIScreen mainScreen].bounds.size.width - 20;
    view.yj_height = strategy.cellHeight;
    [self addSubview:view];
    //一排最多显示
    int maxShowNumber = 4;
    
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    CGFloat buttonW = ([UIScreen mainScreen].bounds.size.width - 20) / maxShowNumber;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i < strategy.channels.count; i++) {
        YJChannel *channel = self.strategy.channels[i];
        
        YJChannelBtn *button = [YJChannelBtn buttonWithType:(UIButtonTypeCustom)];
        
        [button addTarget:self action:@selector(channelDetail) forControlEvents:(UIControlEventTouchUpInside)];
        
        [button sd_setImageWithURL:[NSURL URLWithString:channel.icon_url] forState:(UIControlStateNormal)];
        [button setTitle:channel.name forState:(UIControlStateNormal)];
       
        buttonX = (i % maxShowNumber) * buttonW;
        buttonY = (i / maxShowNumber) * buttonH;
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    
        [view addSubview:button];
    }
  
}

- (void)channelDetail{
    YJNslogFunc
}

+ (YJClassifyStrategyCell *)strategyCell{
    return [[NSBundle mainBundle] loadNibNamed:@"YJClassifyStrategyCell" owner:nil options:nil][0];
}
+ (NSString *)ID{
    return @"YJClassifyStrategyCell";
}
- (void)setFrame:(CGRect)frame{
    frame.size.height -= 10;
    [super setFrame:frame];
}
@end
