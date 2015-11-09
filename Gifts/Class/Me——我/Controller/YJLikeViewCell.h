//
//  YJLikeViewCell.h
//  Gifts
//
//  Created by yjadair on 15/11/9.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJMeRowCell;
@interface YJLikeViewCell : UITableViewCell
+ (id)ID;
@property (strong, nonatomic) YJMeRowCell *rowCell;
/*<#name#>*/
@property (assign, nonatomic) CGFloat likeCellH;
+ (YJLikeViewCell *)likemCell;
@end
