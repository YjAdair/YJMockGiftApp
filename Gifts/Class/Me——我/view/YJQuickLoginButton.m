//
//  XMGQuickLoginButton.m
//  3期-百思不得姐
//
//  Created by xiaomage on 15/9/2.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import "YJQuickLoginButton.h"

@implementation YJQuickLoginButton

- (void)awakeFromNib
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整图片的位置和尺寸
    self.imageView.yj_y = 10;
    self.imageView.yj_centerX = self.yj_width * 0.5;
    
    // 调整文字的位置和尺寸
    self.titleLabel.yj_x = 0;
    self.titleLabel.yj_y = self.imageView.yj_height;
    self.titleLabel.yj_width = self.yj_width;
    self.titleLabel.yj_height = self.yj_height - self.titleLabel.yj_y;
}
@end
