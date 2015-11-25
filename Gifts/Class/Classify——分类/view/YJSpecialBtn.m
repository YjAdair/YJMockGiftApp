//
//  YJSpecialBtn.m
//  Gifts
//
//  Created by yjadair on 15/11/21.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJSpecialBtn.h"

@implementation YJSpecialBtn

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.imageView.yj_x = self.yj_width - self.imageView.yj_width;
    self.titleLabel.yj_x = 0;
    
}
@end
