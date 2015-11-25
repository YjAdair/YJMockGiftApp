//
//  YJHotCell.m
//  Gifts
//
//  Created by yjadair on 15/11/13.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJHotCell.h"
#import <UIImageView+WebCache.h>
@interface YJHotCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
/*<#name#>*/
@property (strong, nonatomic) NSMutableArray *collectionIconData;
@end
@implementation YJHotCell

- (NSMutableArray *)collectionIconData{
    if (!_collectionIconData) {
        _collectionIconData = [NSMutableArray array];
    }
    return _collectionIconData;
}
+ (NSString *)ID{
    return @"hotCell";
}
+ (YJHotCell *)hotCell{
    return [[NSBundle mainBundle] loadNibNamed:@"YJHotCell" owner:nil options:nil][0];
}
- (void)setHotDetail:(YJHotDetail *)hotDetail{
    _hotDetail = hotDetail;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:hotDetail.cover_image_url]placeholderImage:[UIImage OriginImage:[UIImage imageNamed:@"PlaceHolderImage_small"] scaleToSize:CGSizeMake(20, 20)]];
    
    self.title.text = hotDetail.name;
    
    self.money.text = [NSString stringWithFormat:@"￥%@",hotDetail.price];
    
    self.likeCount.text = [NSString stringWithFormat:@"%d",hotDetail.favorites_count];
}
@end
