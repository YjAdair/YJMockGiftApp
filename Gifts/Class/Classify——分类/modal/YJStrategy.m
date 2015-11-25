//
//  YJStrategy.m
//  Gifts
//
//  Created by yjadair on 15/11/21.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJStrategy.h"
#import <MJExtension.h>
@implementation YJStrategy

+ (void)initialize{
    
    [YJStrategy mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"channels": @"YJChannel"
                 
                 };
    }];
}

- (CGFloat)cellHeight{
    
    CGFloat cellHeight = 31.5;
    NSInteger count = (self.channels.count + 4 - 1) / 4;
    cellHeight += count * ([UIScreen mainScreen].bounds.size.width - 20) / 4 + 20;

    return cellHeight;
}

@end
