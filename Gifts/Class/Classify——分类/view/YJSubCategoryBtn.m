//
//  YJSubCategoryBtn.m
//  Gifts
//
//  Created by yjadair on 15/11/21.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJSubCategoryBtn.h"

@implementation YJSubCategoryBtn

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
    self.imageView.yj_y = 10;
    self.imageView.yj_width = 60;
    self.imageView.yj_height = 60;
    self.imageView.yj_centerX = self.yj_width * 0.5;
    
    // 调整文字的位置和尺寸
    self.titleLabel.yj_x = 0;
    self.titleLabel.yj_y = self.imageView.yj_height + 10;
    self.titleLabel.yj_width = self.yj_width - 10;
    self.titleLabel.yj_height = self.yj_height - self.titleLabel.yj_y;
    self.titleLabel.font = [UIFont systemFontOfSize:14];

}

- (void)setHighlighted:(BOOL)highlighted{
    
}

@end
