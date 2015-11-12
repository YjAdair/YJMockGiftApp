//
//  YJChoicensCell.h
//  Gifts
//
//  Created by yjadair on 15/11/11.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJChoicenRowItem.h"
@interface YJChoicensCell : UITableViewCell
/*<#name#>*/
@property (strong, nonatomic) YJChoicenRowItem *itemCell;
/*<#name#>*/
@property (assign, nonatomic) CGFloat cellHeight;
+ (YJChoicensCell *)choicensCell;
+ (NSString *)ID;
@end
