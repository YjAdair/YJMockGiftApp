//
//  YJNormalViewCell.h
//  Gifts
//
//  Created by yjadair on 15/11/9.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJMeRowCell;
@interface YJNormalViewCell : UITableViewCell

/*<#name#>*/
@property (strong, nonatomic) YJMeRowCell *rowCell;

+ (id)ID;

+ (YJNormalViewCell *)normalCell;
@end
