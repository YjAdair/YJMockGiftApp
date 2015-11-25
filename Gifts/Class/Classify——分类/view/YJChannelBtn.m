//
//  YJChannelBtn.m
//  Gifts
//
//  Created by yjadair on 15/11/21.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJChannelBtn.h"

@implementation YJChannelBtn

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整图片的位置和尺寸
    self.imageView.yj_y = 0;
    self.imageView.yj_width = 50;
    self.imageView.yj_height = 50;
    self.imageView.yj_centerX = self.yj_width * 0.5;

    // 调整文字的位置和尺寸
    self.titleLabel.yj_x = 0;
    self.titleLabel.yj_y = self.imageView.yj_height;
    self.titleLabel.yj_width = self.yj_width;
    self.titleLabel.yj_height = self.yj_height - self.titleLabel.yj_y;

}

- (void)setHighlighted:(BOOL)highlighted{
    
}

@end
