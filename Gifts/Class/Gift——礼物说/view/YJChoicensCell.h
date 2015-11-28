//
//  YJChoicensCell.h
//  Gifts
//
//  Created by yjadair on 15/11/11.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJGiftCellDetail.h"

@interface YJChoicensCell : UITableViewCell
/*<#name#>*/
@property (assign, nonatomic) CGFloat cellHeight;

/*<#name#>*/
@property (strong, nonatomic) YJGiftCellDetail *cellDetail;
@property (weak, nonatomic) IBOutlet UIView *timeView;
+ (YJChoicensCell *)choicensCell;
+ (NSString *)ID;
@end
