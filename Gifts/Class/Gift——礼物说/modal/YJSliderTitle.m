//
//  YJSliderTitle.m
//  Gifts
//
//  Created by yjadair on 15/11/25.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJSliderTitle.h"
#import "YJSliderTitle.h"
@implementation YJSliderTitle


+ (void)initialize{
    
    [YJSliderTitle mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID": @"id"
                 
                 };
    }];
}
@end
