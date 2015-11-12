//
//  YJChoicensCell.m
//  Gifts
//
//  Created by yjadair on 15/11/11.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJChoicensCell.h"
@interface YJChoicensCell()
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
@implementation YJChoicensCell

- (void)setItemCell:(YJChoicenRowItem *)itemCell{
    _itemCell = itemCell;
    self.cellImage.image = [UIImage imageWithData:itemCell.imageData];
    self.likeCount.text = itemCell.likeCount.stringValue;
    [self.likeCount sizeToFit];
    
    self.title.text = itemCell.title;
}

+ (YJChoicensCell *)choicensCell{
    return [[NSBundle mainBundle]loadNibNamed:@"YJChoicensCell" owner:nil options:nil][0];
}

- (CGFloat)cellHeight{
    return CGRectGetHeight(self.cellImage.frame);
}
@end
