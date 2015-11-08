//
//  UIView+Frame.h
//  彩票
//
//  Created by xiaomage on 15/9/22.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

// 如果@property在声明类的时候使用,那么@property会自动生成属性,分类里面不能添加属性
// 如果@property在分类中使用,不会生成成员属性,只会生成get,set方法声明
@property (nonatomic, assign) CGFloat yj_width;
@property (nonatomic, assign) CGFloat yj_height;
@property (nonatomic, assign) CGFloat yj_x;
@property (nonatomic, assign) CGFloat yj_y;
@property (nonatomic, assign) CGFloat yj_centerX;
@property (nonatomic, assign) CGFloat yj_centerY;

@property (nonatomic, assign) CGFloat yj_right;
@property (nonatomic, assign) CGFloat yj_bottom;
@end
