//
//  YJTitleManageView.m
//  Gifts
//
//  Created by yjadair on 15/11/26.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJTitleManageView.h"
@interface YJTitleManageView()
/*<#name#>*/
@property (weak, nonatomic) UIView *subTitleButtonManageView;
@end
@implementation YJTitleManageView

+ (YJTitleManageView *)titleManageiew{
    
    return [[NSBundle mainBundle] loadNibNamed:@"YJTitleManageView" owner:nil options:nil][0];
}
@end
