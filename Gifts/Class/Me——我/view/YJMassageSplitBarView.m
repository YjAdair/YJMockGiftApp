
//
//  YJSplitBarView.m
//  confidant
//
//  Created by yjadair on 15/10/21.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJMassageSplitBarView.h"

@interface YJMassageSplitBarView()<UIScrollViewDelegate>
@property (weak, nonatomic)  UIButton *left;

@property (weak, nonatomic)  UIButton *centre;
@property (weak, nonatomic)  UIButton *right;
@property (weak, nonatomic)  UIView *backView;
@property (weak, nonatomic)  UIView *navView;


@end
@implementation YJMassageSplitBarView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
        self.left = left;
        left.tag = 1;
        [left addTarget:self action:@selector(column:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:left];
        
        UIButton *centre = [UIButton buttonWithType:UIButtonTypeCustom];
        self.centre = centre;
        centre.tag = 2;
        [centre addTarget:self action:@selector(column:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:centre];
        
        UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
        self.right = right;
        right.tag = 3;
        [right addTarget:self action:@selector(column:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:right];
        
        UIView *navView = [[UIView alloc]init];
        self.navView = navView;
        //navView的fram不能放到layoutSubviews中设置.因为每次改变navView的fram时就会调用layoutSubviews,从而使navView的尺寸重置
        [self addSubview:navView];
        }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
 
    self.left.frame = CGRectMake(50, 5, 30, 30);
    [self.left sizeToFit];
    self.centre.frame = CGRectMake( [UIScreen mainScreen].bounds.size.width / 2 - 15, 5, 30, 30);
    [self.centre sizeToFit];
    self.right.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 50 - 30, 5, 30, 30);
    [self.right sizeToFit];
    //确保改变navView的fram值时，不会使navView重置
    if (!self.navView.frame.size.width) {
        self.navView.frame = CGRectMake(50, 35, 30, 3);
    }

    
}
+ (instancetype)splitBarViewWithShowInRect:(CGRect)rect BackgroundColor:(UIColor *)color LeftBtn:(NSString *)leftName centre:(NSString *)centreName right:(NSString *)rightName{
    
    YJMassageSplitBarView *splitBar = [[YJMassageSplitBarView alloc]init];

    splitBar.frame = rect;
    
    [splitBar.left setTitle:leftName forState:UIControlStateNormal];
    
    [splitBar.centre setTitle:centreName forState:UIControlStateNormal];
    [splitBar.right setTitle:rightName forState:UIControlStateNormal];
    
    [splitBar.left setTitle:leftName forState:UIControlStateHighlighted];
    [splitBar.centre setTitle:centreName forState:UIControlStateHighlighted];
    [splitBar.right setTitle:rightName forState:UIControlStateHighlighted];
    [splitBar.backView setBackgroundColor:color];
    
    return splitBar;
}
- (void)setBtnNorColor:(UIColor *)btnNorColor{
    _btnNorColor = btnNorColor;
    [_left setTitleColor:_btnNorColor forState:UIControlStateNormal];
    [_centre setTitleColor:_btnNorColor forState:UIControlStateNormal];
    [_right setTitleColor:_btnNorColor forState:UIControlStateNormal];
}
- (void)setBtnHigColor:(UIColor *)btnHigColor{
    _btnHigColor = btnHigColor;
    [_left setTitleColor:_btnHigColor forState:UIControlStateHighlighted];
    [_centre setTitleColor:_btnHigColor forState:UIControlStateHighlighted];
    [_right setTitleColor:_btnHigColor forState:UIControlStateHighlighted];
}

- (void)setNavViewColor:(UIColor *)navViewColor{
    _navViewColor = navViewColor;
    _navView.backgroundColor = navViewColor;
}

- (void)animation:(void(^)())block{
    [UIView animateWithDuration:0.3 animations:^{
        block();
    }];
}
#pragma mark 分栏View之间的切换
- (void)column:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
        {
            [self animation:^{
                CGRect tempR = self.navView.frame;
                tempR.origin.x = self.left.frame.origin.x;
                tempR.size.width = self.left.frame.size.width;
                self.navView.frame = tempR;
                           NSLog(@"later%lf", self.navView.frame.origin.x);
            }];
            
            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            break;
        }
            
        case 2:
        {
            [self animation:^{
   
                CGRect tempR = self.navView.frame;
                tempR.origin.x = self.centre.frame.origin.x;
                tempR.size.width = self.centre.frame.size.width;
                self.navView.frame = tempR;
           
            }];
            [self.scrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width, 0) animated:YES];
            break;
        }
        case 3:
        {
            [self animation:^{
                CGRect tempR = self.navView.frame;
                tempR.origin.x = self.right.frame.origin.x;
                tempR.size.width = self.right.frame.size.width;
                self.navView.frame = tempR;
            }];
            [self.scrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width * 2, 0) animated:YES];
            break;
        }

        default:
            break;
    }

}

- (void)setScale:(CGFloat)scale offsetX:(CGFloat)offsetX{
 
    if (offsetX >= 0 && offsetX <= [UIScreen mainScreen].bounds.size.width) {
        [self animation:^{
            CGRect tempC = self.navView.frame;
            tempC.origin.x = self.left.frame.origin.x + 2 *scale * (self.centre.frame.origin.x - self.left.frame.origin.x);
            tempC.size.width = self.left.frame.size.width + 2 *scale * (self.centre.frame.size.width - self.left.frame.size.width);
            self.navView.frame = tempC;
            
        }];
    }else if (offsetX >= [UIScreen mainScreen].bounds.size.width && offsetX <= 2 *[UIScreen mainScreen].bounds.size.width){
        [self animation:^{
            CGRect tempC = self.navView.frame;
            tempC.origin.x = self.centre.frame.origin.x +  scale * (self.right.frame.origin.x - self.centre.frame.origin.x);
            tempC.size.width = self.centre.frame.size.width - scale * (self.centre.frame.size.width - self.left.frame.size.width);
            self.navView.frame = tempC;
            
        }];
    }
}

@end
