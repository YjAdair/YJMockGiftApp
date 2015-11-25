//
//  YJClassifySpecialButton.m
//  Gifts
//
//  Created by yjadair on 15/11/21.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJClassifySpecialButton.h"

@implementation YJClassifySpecialButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        self.imageView.layer.cornerRadius = 10;
        self.imageView.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted{
    
}
@end
