//
//  YJHotGiftComment.h
//  Gifts
//
//  Created by yjadair on 15/11/18.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJHotGiftUser.h"
@interface YJHotGiftComment : NSObject
/*<#name#>*/
@property (strong, nonatomic) YJHotGiftUser *user;
/*<#name#>*/
@property (strong, nonatomic) NSString *content;
@end
