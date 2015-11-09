//
//  YJLikeViewCell.m
//  Gifts
//
//  Created by yjadair on 15/11/9.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJLikeViewCell.h"
#import "YJMeRowCell.h"
@interface YJLikeViewCell()

@property (weak, nonatomic) IBOutlet UIView *BtnView;

@property (weak, nonatomic) IBOutlet UIScrollView *likeScrollView;
@end
@implementation YJLikeViewCell

- (void)awakeFromNib {
    // Initialization code
}

+ (id)ID{
    return @"likeCell";
}

+ (YJLikeViewCell *)likemCell{
    return [[NSBundle mainBundle] loadNibNamed:@"YJLikeViewCell" owner:nil options:nil][0];
}
- (void)setRowCell:(YJMeRowCell *)rowCell{
    _rowCell = rowCell;

}
- (CGFloat)likeCellH{
    return _BtnView.bounds.size.height + _likeScrollView.bounds.size.height;
}
@end
