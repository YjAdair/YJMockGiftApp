//
//  YJBaseViewController.h
//  Gifts
//
//  Created by yjadair on 15/11/25.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJSliderTitle.h"
@interface YJBaseViewController : UITableViewController

/*<#name#>*/
@property (strong, nonatomic) YJSliderTitle *sliderTitle;
- (NSString *)giftControllerId;
@end
