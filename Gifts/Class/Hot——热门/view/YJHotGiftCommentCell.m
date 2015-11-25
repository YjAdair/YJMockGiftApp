//
//  YJHotGiftCommentCell.m
//  Gifts
//
//  Created by yjadair on 15/11/18.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJHotGiftCommentCell.h"
#import <UIImageView+WebCache.h>
@interface YJHotGiftCommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *UserName;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end
@implementation YJHotGiftCommentCell

- (void)setHeadIconUrl:(NSString *)headIconUrl{
    _headIconUrl = headIconUrl;
    
    [self.headIcon sd_setImageWithURL:[NSURL URLWithString:headIconUrl]];
}
- (void)setUserNames:(NSString *)UserNames{
    _UserNames = UserNames;
    
    self.UserName.text = UserNames;
}
- (void)setContents:(NSString *)contents{
    _contents = contents;
    
    self.content.text = contents;
}
+ (NSString *)ID{
    return @"YJHotGiftCommentCell";
}
- (CGFloat)cellHeight{
    return CGRectGetMaxY(self.content.frame) + 20;
}
+ (YJHotGiftCommentCell *)commentCell{
    return [[NSBundle mainBundle]loadNibNamed:@"YJHotGiftCommentCell" owner:nil options:nil][0];
}
@end
