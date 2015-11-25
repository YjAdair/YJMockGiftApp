//
//  YJStrategy.h
//  Gifts
//
//  Created by yjadair on 15/11/21.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YJChannel;
@interface YJStrategy : NSObject

/*<#name#>*/
@property (strong, nonatomic) NSString *name;
/*<#name#>*/
@property (strong, nonatomic) NSArray<YJChannel *> *channels;

- (CGFloat)cellHeight;
@end
