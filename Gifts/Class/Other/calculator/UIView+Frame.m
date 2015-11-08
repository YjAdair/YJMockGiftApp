//
//  UIView+Frame.m
//  彩票
//
//  Created by xiaomage on 15/9/22.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
- (CGFloat)yj_width
{
    return self.bounds.size.width;
}
- (void)setYj_width:(CGFloat)yj_width
{
    CGRect frame = self.frame;
    frame.size.width = yj_width;
    self.frame = frame;
}
- (CGFloat)yj_height
{
    return self.bounds.size.height;
}
- (void)setYj_height:(CGFloat)yj_height
{
    CGRect frame = self.frame;
    frame.size.height = yj_height;
    self.frame = frame;
}
- (CGFloat)yj_x
{
    return self.frame.origin.x;
}
- (void)setYj_x:(CGFloat)yj_x
{
    CGRect frame = self.frame;
    frame.origin.x = yj_x;
    self.frame = frame;

}
- (CGFloat)yj_y
{
    return self.frame.origin.y;
}
- (void)setYj_y:(CGFloat)yj_y
{
    CGRect frame = self.frame;
    frame.origin.y = yj_y;
    self.frame = frame;

}
- (CGFloat)yj_centerX
{
    return self.center.x;
}

- (void)setYj_centerX:(CGFloat)yj_centerX
{
    CGPoint center = self.center;
    center.x = yj_centerX;
    self.center = center;
}

- (CGFloat)yj_centerY
{
    return self.center.y;
}

- (void)setYj_centerY:(CGFloat)yj_centerY
{
    CGPoint center = self.center;
    center.y = yj_centerY;
    self.center = center;
}

- (CGFloat)yj_right
{
    //    return self.xmg_x + self.xmg_width;
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)yj_bottom
{
    //    return self.xmg_y + self.xmg_height;
    return CGRectGetMaxY(self.frame);
}

- (void)setYj_right:(CGFloat)yj_right
{
    self.yj_x = yj_right - self.yj_width;
}

- (void)setYj_bottom:(CGFloat)yj_bottom
{
    self.yj_y = yj_bottom - self.yj_height;
}
@end
