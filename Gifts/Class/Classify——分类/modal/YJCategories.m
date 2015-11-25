//
//  YJCategories.m
//  Gifts
//
//  Created by yjadair on 15/11/21.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJCategories.h"
#import <MJExtension.h>
@implementation YJCategories

+ (void)initialize{
    
    [YJCategories mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"subcategories" : @"YJSubcategories"
                 
                 };
    }];
    
}
@end
