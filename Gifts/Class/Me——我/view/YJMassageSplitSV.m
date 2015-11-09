//
//  YJMassageSplitSV.m
//  confidant
//
//  Created by yjadair on 15/10/23.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJMassageSplitSV.h"
#define kSViewW [UIScreen mainScreen].bounds.size.width
#define kSViewH [UIScreen mainScreen].bounds.size.height

@implementation YJMassageSplitSV

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)addViewController{

    self.contentSize = CGSizeMake(kSViewW * 3, 0);
    self.pagingEnabled = YES;
    self.showsVerticalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;


    UIView *one = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSViewW, kSViewH)];
    one.backgroundColor = [UIColor magentaColor];
    [self addSubview:one];

    UIView *two = [[UIView alloc]initWithFrame:CGRectMake(kSViewW, 0, kSViewW, kSViewH)];
    two.backgroundColor = [UIColor redColor];
    [self addSubview:two];

    UIView *three = [[UIView alloc]initWithFrame:CGRectMake(kSViewW * 2, 0, kSViewW, kSViewH)];
    three.backgroundColor = [UIColor blueColor];
    [self addSubview:three];
    
}
@end
