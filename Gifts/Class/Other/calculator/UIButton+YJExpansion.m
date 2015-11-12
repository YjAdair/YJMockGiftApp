//
//  UIButton+YJExpansion.m
//  Gifts
//
//  Created by yjadair on 15/11/13.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "UIButton+YJExpansion.h"

@implementation UIButton (YJExpansion)
- (void)setBtnWithNorImage:(UIImage *)NorImage SelImage:(UIImage *)selImage TitleColor:(UIColor *)titleColor Title:(NSString *)title{
    
    [self setImage:NorImage forState:(UIControlStateNormal)];
    [self setImage:selImage forState:(UIControlStateHighlighted)];
    [self setTitle:title forState:(UIControlStateNormal)];
    [self setTitleColor:titleColor forState:(UIControlStateNormal)];
    [self setTitle:title forState:(UIControlStateHighlighted)];
    [self setTitleColor:titleColor forState:(UIControlStateHighlighted)];
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
}
@end
