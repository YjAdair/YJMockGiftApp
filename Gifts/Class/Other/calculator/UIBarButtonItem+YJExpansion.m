//
//  UIBarButtonItem+YJExpansion.m
//  百思不得姐
//
//  Created by yjadair on 15/11/6.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "UIBarButtonItem+YJExpansion.h"

@implementation UIBarButtonItem (YJExpansion)
+ (instancetype)itemWithNorImage:(UIImage *)norImage Target:(id)target Action:(SEL)selector{
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setImage:norImage forState:(UIControlStateNormal)];
    [btn addTarget:target action:selector forControlEvents:(UIControlEventTouchUpInside)];
    [btn sizeToFit];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
    
}

+ (instancetype)itemWithImage:(UIImage *)norImage  Target:(id)target Action:(SEL)selector{
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setImage:norImage forState:(UIControlStateNormal)];
    [btn addTarget:target action:selector forControlEvents:(UIControlEventTouchUpInside)];
    [btn sizeToFit];
    static int i = 1;
    if (i == 2) {
        
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -40);
    }
    i++;
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
    
}
@end
