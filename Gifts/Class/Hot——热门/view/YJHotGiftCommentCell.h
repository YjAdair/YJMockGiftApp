//
//  YJHotGiftCommentCell.h
//  Gifts
//
//  Created by yjadair on 15/11/18.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJHotGiftCommentCell : UITableViewCell
@property (strong, nonatomic)  NSString *headIconUrl;
@property (strong, nonatomic)  NSString *UserNames;
@property (strong, nonatomic)  NSString *contents;

+ (NSString *)ID;
- (CGFloat)cellHeight;
+ (YJHotGiftCommentCell *)commentCell;
@end
