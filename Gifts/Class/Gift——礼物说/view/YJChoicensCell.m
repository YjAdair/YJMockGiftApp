//
//  YJChoicensCell.m
//  Gifts
//
//  Created by yjadair on 15/11/11.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJChoicensCell.h"
#import <UIImageView+WebCache.h>
#import "NSString+YJExpansion.h"
@interface YJChoicensCell()
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (weak, nonatomic) IBOutlet UILabel *title;
/*<#name#>*/
@property (strong, nonatomic) NSMutableArray *preIndexPathArr;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *showTime;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellImageTopConstraint;

@end
@implementation YJChoicensCell

- (NSMutableArray *)preIndexPathArr{
    if (!_preIndexPathArr) {
        _preIndexPathArr = [NSMutableArray array];
    }
    return _preIndexPathArr;
}
- (void)setCellDetail:(YJGiftCellDetail *)cellDetail{
    
    _cellDetail = cellDetail;
    NSLog(@"%d", cellDetail.isShowTime);
    if (!cellDetail.isShowTime) {
        self.cellImageTopConstraint.constant -= 20;
        self.showTime.hidden = YES;
    }
    
    NSString *publishDate = [NSString weekdayStringFromDate:cellDetail.published_at];
    self.timeLabel.text = publishDate;
    
    self.title.text = cellDetail.title;
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    [btn setImage:[UIImage imageNamed:@"Feed_FavoriteIcon"] forState:(UIControlStateNormal)];
    [btn setTitle:[NSString stringWithFormat:@"%d",cellDetail.likes_count] forState:(UIControlStateNormal)];
    [btn setBackgroundColor:[UIColor darkGrayColor]];
    btn.layer.cornerRadius = 13;
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn sizeToFit];
    CGFloat btnW = [[NSString stringWithFormat:@"%d",cellDetail.likes_count] sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]}].width + btn.imageView.yj_width + 15;
    CGFloat btnH = [[NSString stringWithFormat:@"%d",cellDetail.likes_count] sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]}].height + 5;
    CGFloat btnX = YJScreenW - btnW - 15;
    CGFloat btnY = 5;
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    
    [self.cellImage sd_setImageWithURL:[NSURL URLWithString:cellDetail.cover_image_url   ] placeholderImage:[UIImage imageNamed:@"PlaceHolderImage_Big"]];
    
    [self.cellImage addSubview:btn];
}
+ (NSString *)ID{
    return @"choicensCell";
}
+ (YJChoicensCell *)choicensCell{
    return [[NSBundle mainBundle]loadNibNamed:@"YJChoicensCell" owner:nil options:nil][0];
}

- (CGFloat)cellHeight{
    return CGRectGetHeight(self.cellImage.frame);
}

@end
