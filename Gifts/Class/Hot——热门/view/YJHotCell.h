//
//  YJHotCell.h
//  Gifts
//
//  Created by yjadair on 15/11/13.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJHotCell : UICollectionViewCell
/*<#name#>*/
@property (strong, nonatomic) NSString *collectionImageUrl;
/*<#name#>*/
@property (strong, nonatomic) NSString *collectionTitle;
/*<#name#>*/
@property (strong, nonatomic) NSString *collectionPrice;
/*<#name#>*/
@property (strong, nonatomic) NSNumber *collectionFavoritesCount;
+ (NSString *)ID;
+ (YJHotCell *)hotCell;
@end
