//
//  YJAutoScrollerView.h
//  无限滚动
//
//  Created by yjadair on 15/10/23.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface YJAutoScrollerView : UIView
/*记录显示页码*/
@property (nonatomic, assign) NSInteger currentPage;
/*保存图片资源*/
@property (nonatomic, strong) NSMutableArray *imageViewAry;
/*显示图片的scrollView*/
@property (nonatomic, readonly) UIScrollView *scrollView;

//是否自动翻页
-(void)shouldAutoShow:(BOOL)shouldStart;
@end
