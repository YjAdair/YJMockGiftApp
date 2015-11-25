//
//  YJClassifyStrategyCell.h
//  Gifts
//
//  Created by yjadair on 15/11/21.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJStrategy;
@interface YJClassifyStrategyCell : UITableViewCell

/*<#name#>*/
@property (strong, nonatomic) YJStrategy *strategy;
+ (YJClassifyStrategyCell *)strategyCell;
+ (NSString *)ID;
@end
