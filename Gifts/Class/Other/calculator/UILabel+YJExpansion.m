//
//  UILabel+YJExpansion.m
//  Gifts
//
//  Created by yjadair on 15/11/9.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "UILabel+YJExpansion.h"

@implementation UILabel (YJExpansion)
+ (instancetype)labelWithSize:(CGFloat)size TitleColor:(UIColor *)color Title:(NSString *)title{
    UILabel *label = [[UILabel alloc]init];
    label.text = title;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:size];
    [label sizeToFit];
    return label;
}
@end
