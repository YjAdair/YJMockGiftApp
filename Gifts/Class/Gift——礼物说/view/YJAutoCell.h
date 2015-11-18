//
//  YJAutoCell.h
//  Gifts
//
//  Created by yjadair on 15/11/12.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJAutoCell : UITableViewCell
/*存放礼物说广告图片地址*/
@property (strong, nonatomic) NSMutableArray *bannerImageUrlArr;

+ (NSString *)ID;
+ (YJAutoCell *)autoCell;
- (CGFloat)cellHeight;
@end
