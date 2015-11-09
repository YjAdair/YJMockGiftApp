//
//  YJNormalViewCell.m
//  Gifts
//
//  Created by yjadair on 15/11/9.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJNormalViewCell.h"
#import "YJMeRowCell.h"
@interface YJNormalViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *norImage;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end
@implementation YJNormalViewCell

- (void)setRowCell:(YJMeRowCell *)rowCell{
    _rowCell = rowCell;
    self.label.text = rowCell.title;
    self.norImage.image = rowCell.image;
    
}
+ (id)ID{
    return @"norCell";
}

+ (YJNormalViewCell *)normalCell{
    return [[NSBundle mainBundle] loadNibNamed:@"YJNormalViewCell" owner:nil options:nil][0];
}
- (void)awakeFromNib {
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}


@end
