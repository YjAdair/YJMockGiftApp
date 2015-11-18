//
//  YJAutoCell.h
//  Gifts
//
//  Created by yjadair on 15/11/12.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJHotAutoCell;
@protocol YJHotAutoCellDelegate <NSObject>

- (void)hotAutoCell:(YJHotAutoCell *)hotAutoCell;

@end

@interface YJHotAutoCell : UITableViewCell
/*热门Item地址*/
@property (strong, nonatomic) NSString *hotGiftItemUrl;
/*<#name#>*/
@property (weak, nonatomic) id<YJHotAutoCellDelegate> delegate;
+ (NSString *)ID;
+ (YJHotAutoCell *)HotautoCell;
- (CGFloat)cellHeight;
@end
