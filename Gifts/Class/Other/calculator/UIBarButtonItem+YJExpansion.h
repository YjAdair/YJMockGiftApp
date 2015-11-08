//
//  UIBarButtonItem+YJExpansion.h
//  百思不得姐
//
//  Created by yjadair on 15/11/6.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YJExpansion)

+ (instancetype)itemWithNorImage:(UIImage *)norImage Target:(id)target Action:(SEL)selector;
+ (instancetype)itemWithImage:(UIImage *)norImage  Target:(id)target Action:(SEL)selector;
@end
