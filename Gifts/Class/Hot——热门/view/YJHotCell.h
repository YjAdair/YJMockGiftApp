//
//  YJHotCell.h
//  Gifts
//
//  Created by yjadair on 15/11/13.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJHotDetail.h"
@interface YJHotCell : UICollectionViewCell

/*<#name#>*/
@property (strong, nonatomic) YJHotDetail *hotDetail;

+ (NSString *)ID;
+ (YJHotCell *)hotCell;
@end
