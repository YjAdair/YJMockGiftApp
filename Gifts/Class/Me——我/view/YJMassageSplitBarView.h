//
//  YJSplitBarView.h
//  confidant
//
//  Created by yjadair on 15/10/21.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface YJMassageSplitBarView : UIView
/*分隔栏对应的scrollView*/
@property (weak, nonatomic) UIScrollView *scrollView;
/*普通状态下的按钮颜色*/
@property (copy, nonatomic) UIColor *btnNorColor;
/*高亮状态下的按钮颜色*/
@property (copy, nonatomic) UIColor *btnHigColor;
/*分隔栏滑块颜色*/
@property (copy, nonatomic) UIColor *navViewColor;
//设置分隔栏基本属性
+ (instancetype)splitBarViewWithShowInRect:(CGRect)rect BackgroundColor:(UIColor *)color LeftBtn:(NSString *)leftName centre:(NSString *)centreName right:(NSString *)rightName ;

//根据scrollView的滑动来设置navView的位置和尺寸
- (void)setScale:(CGFloat)scale offsetX:(CGFloat)offsetX;
@end
