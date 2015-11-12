//
//  YJGiftViewController.m
//  Gifts
//
//  Created by yjadair on 15/11/8.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJGiftViewController.h"

#import "YJChoicenessController.h"
#import "YJHaiTaoController.h"
#import "YJSportsController.h"
static CGFloat const space = 20;
#define YJScreenW [UIScreen mainScreen].bounds.size.width
#define YJScreenH [UIScreen mainScreen].bounds.size.height
#define YJSliderTitleUrl @"http://api.liwushuo.com/v2/channels/preset?gender=1&generation=1"
@interface YJGiftViewController ()<UIScrollViewDelegate>



/*<#name#>*/
@property (weak, nonatomic) UILabel *label;

@property (nonatomic, weak) UILabel *selLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@property (nonatomic, strong) NSMutableArray *titleLabels;

/*<#name#>*/
@property (strong, nonatomic) UIView *sliderView;

/*<#name#>*/
@property (assign, nonatomic) CGFloat total;
/*<#name#>*/
@property (weak, nonatomic) UILabel *preLabel;
/*<#name#>*/
@property (assign, nonatomic) CGFloat preLabelW;

/*<#name#>*/
@property (strong, nonatomic) NSDictionary *sliderTitleArr;
@end

@implementation YJGiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置界面标题
    [self.navigationItem setTitleView:[UILabel labelWithSize:20 TitleColor:[UIColor whiteColor] Title:@"礼物说"]];
    //设置navBar右边Item
    UIBarButtonItem *nightItem = [UIBarButtonItem itemWithNorImage:[UIImage imageNamed:@"icon_navigation_nightmode"] Target:self Action:@selector(search)];
    UIBarButtonItem *searchItem = [UIBarButtonItem itemWithNorImage:[UIImage imageNamed:@"Feed_SearchBtn"] Target:self Action:@selector(nightmode)];
    self.navigationItem.rightBarButtonItems = @[searchItem, nightItem];
    
    //获取sliderTitle
    [self getTitleAFNetworking];
    
}
#pragma mark 获取sliderTitle
- (void)getTitleAFNetworking{
    //创建请求管理者
    AFHTTPRequestOperationManager *requestManage = [AFHTTPRequestOperationManager manager];
    //设置返回类型——JSON
    requestManage.requestSerializer = [AFJSONRequestSerializer serializer];
    //发送GET请求
    [requestManage GET:YJSliderTitleUrl parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        self.sliderTitleArr = responseObject;
       
        // 1.添加所有子控制器
        [self setUpChildViewController];
        
        // 2.添加所有子控制器对应标题
        [self setUpTitleLabel];
        
        // iOS7会给导航控制器下所有的UIScrollView顶部添加额外滚动区域
        // 不想要添加
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        // 3.初始化UIScrollView
        [self setUpScrollView];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"sliderTitle数据请求失败");
    }];
                                                    
    
}
- (void)search{
    YJNslogFunc
}
- (void)nightmode{
    YJNslogFunc
}






/*
 网易新闻实现步骤:
 1.搭建结构(导航控制器)
 * 自定义导航控制器根控制器NewsViewController
 * 搭建NewsViewController界面(上下滚动条)
 * 确定NewsViewController有多少个子控制器,添加子控制器
 2.设置上面滚动条标题
 * 遍历所有子控制器
 3.监听滚动条标题点击
 * 3.1 让标题选中,文字变为红色
 * 3.2 滚动到对应的位置
 * 3.3 在对应的位置添加子控制器view
 4.监听滚动完成时候
 * 4.1 在对应的位置添加子控制器view
 * 4.2 选中子控制器对应的标题
 */

- (NSMutableArray *)titleLabels
{
    if (_titleLabels == nil) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}

#pragma mark 3.初始化UIScrollView
// 初始化UIScrollView
- (void)setUpScrollView
{
    NSUInteger count = self.childViewControllers.count;
    // 设置标题滚动条
    self.titleScrollView.contentSize = CGSizeMake(_total + space, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;

    // 设置内容滚动条
    self.contentScrollView.contentSize = CGSizeMake(count * YJScreenW, 0);
    // 开启分页
    self.contentScrollView.pagingEnabled = YES;
    // 没有弹簧效果
    self.contentScrollView.bounces = NO;
    // 隐藏水平滚动条
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    // 设置代理
    self.contentScrollView.delegate = self;
}

#pragma mark 2.添加所有子控制器对应标题
// 添加所有子控制器对应标题
- (void)setUpTitleLabel
{
    NSUInteger count = self.childViewControllers.count;
    
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    CGFloat labelH = self.titleScrollView.frame.size.height;
   
    for (int i = 0; i < count; i++) {
        // 获取对应子控制器
        UIViewController *vc = self.childViewControllers[i];
        
        // 创建label
        UILabel *label = [[UILabel alloc] init];
        
        self.label = label;
        
        
        // 设置label文字
        label.text = vc.title;
        
        CGFloat labelW = [self getLabelSize:label.text];
        
        // 设置尺寸
        label.frame = CGRectMake(labelX + space, labelY, labelW, labelH);
        labelX = CGRectGetMaxX(label.frame);
        
        // 设置高亮文字颜色
        label.highlightedTextColor = [UIColor redColor];
        
        // 设置label的tag
        label.tag = i;
        
        // 设置用户的交互
        label.userInteractionEnabled = YES;
        
        // 文字居中
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        
        // 添加到titleLabels数组
        [self.titleLabels addObject:label];
        
        // 添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClick:)];
        [label addGestureRecognizer:tap];
        
        // 默认选中第0个label
        if (i == 0) {
            [self titleClick:tap];
        }
        
        // 添加label到标题滚动条上
        [self.titleScrollView addSubview:label];
        
        //添加滑块到标题滚动条上
        if (i == 0) {
            _sliderView = [[UIView alloc]initWithFrame:CGRectMake(space, 40, labelW, 2)];
            _sliderView.backgroundColor = [UIColor orangeColor];
            [self.titleScrollView addSubview:_sliderView];
        }
        
    }
    UILabel *lastLabel = [self.titleLabels lastObject];
    _total = CGRectGetMaxX(lastLabel.frame);
}
- (CGFloat)getLabelSize:(NSString *)title{
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
    CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return ceil(size.width) + space;
}
// 设置标题居中
- (void)setUpTitleCenter:(UILabel *)centerLabel
{
    // 计算偏移量
    CGFloat offsetX = centerLabel.center.x - YJScreenW * 0.5;
    
    if (offsetX < 0) offsetX = 0;
    
    // 获取最大滚动范围
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - YJScreenW;
    
    if (offsetX > maxOffsetX) offsetX = maxOffsetX;
    
    
    // 滚动标题滚动条
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
}

#pragma mark - UIScrollViewDelegate
// scrollView一滚动就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    //未加载控制的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width + 1;
    if (index >= _titleLabels.count - 1) {
        index = _titleLabels.count - 1;
    }
    //在未加载控制器的位置添加视图
    [self showUnViewLoaded:index];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    
    
    //    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 1.添加子控制器view
    [self showVc:index];
    
    // 2.把对应的标题选中
    UILabel *selLabel = self.titleLabels[index];
    [self addAnimationWithSelectedItem:selLabel];
    [self selectLabel:selLabel];
    
    // 3.让选中的标题居中
    [self setUpTitleCenter:selLabel];
    
    
}

// 显示控制器的view
- (void)showVc:(NSInteger)index
{
    CGFloat offsetX = index * YJScreenW;
    
    UIViewController *vc = self.childViewControllers[index];
    
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    if (vc.isViewLoaded) return;
    
    vc.view.frame = CGRectMake(offsetX, 0, YJScreenW, YJScreenH);
    
    [self.contentScrollView addSubview:vc.view];
}
//为显示控制器的View时添加临时的View
- (void)showUnViewLoaded:(NSInteger)index{
    CGFloat offsetX = index * YJScreenW;
    UIViewController *vc = self.childViewControllers[index];
    if (!vc.isViewLoaded) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(offsetX, 0, YJScreenW, YJScreenH)];
        imageView.image = [UIImage imageNamed:@"TabBar_gift"];
        [self.contentScrollView addSubview:imageView];
    }
}
// 点击标题的时候就会调用
- (void)titleClick:(UITapGestureRecognizer *)tap
{
    
    // 0.获取选中的label
    UILabel *selLabel = (UILabel *)tap.view;
    [self addAnimationWithSelectedItem:selLabel];
    // 1.标题颜色变成红色,设置高亮状态下的颜色
    [self selectLabel:selLabel];
    
    // 2.滚动到对应的位置
    NSInteger index = selLabel.tag;
    // 2.1 计算滚动的位置
    CGFloat offsetX = index * YJScreenW;
    self.contentScrollView.contentOffset = CGPointMake(offsetX, 0);
    
    // 3.给对应位置添加对应子控制器
    [self showVc:index];
    
    // 4.让选中的标题居中
    [self setUpTitleCenter:selLabel];
    
    
    
}

// 选中label
- (void)selectLabel:(UILabel *)label
{
    if (label == self.selLabel) {
        return;
    }
    // 取消高亮
    _selLabel.highlighted = NO;
    // 取消形变
        _selLabel.transform = CGAffineTransformIdentity;
    // 颜色恢复
    _selLabel.textColor = [UIColor blackColor];
    
    // 高亮
    label.highlighted = YES;
    // 形变
//        label.transform = CGAffineTransformMakeScale(radio, radio);
    
    _selLabel = label;
    
}

#pragma mark  1.添加所有子控制器对应标题
// 添加所有子控制器
- (void)setUpChildViewController
{
    // 精选
    YJChoicenessController *choiceness = [[YJChoicenessController alloc] init];
    choiceness.title = self.sliderTitleArr[@"data"][@"channels"][0][@"name"];
    [self addChildViewController:choiceness];

    // 热点
    YJHaiTaoController *haiTao = [[YJHaiTaoController alloc] init];
    haiTao.title = self.sliderTitleArr[@"data"][@"channels"][3][@"name"];
    [self addChildViewController:haiTao];
    
    // 运动
    YJSportsController *sports = [[YJSportsController alloc] init];
    sports.title = self.sliderTitleArr[@"data"][@"channels"][1][@"name"];
    [self addChildViewController:sports];
  
}

- (void)addAnimationWithSelectedItem:(UILabel *)item {
    // Caculate the distance of translation
    CGFloat dx = CGRectGetMidX(item.frame) - CGRectGetMidX(_selLabel.frame);
    //    CGFloat dx1 = [_titleLabels indexOfObject:item] * item.frame.size.width;
    // Add the animation about translation
    CABasicAnimation *positionAnimation = [CABasicAnimation animation];
    positionAnimation.keyPath = @"position.x";
    positionAnimation.fromValue = @(_sliderView.layer.position.x);
    positionAnimation.toValue = @(_sliderView.layer.position.x + dx);
    
    // Add the animation about size
    CABasicAnimation *boundsAnimation = [CABasicAnimation animation];
    boundsAnimation.keyPath = @"bounds.size.width";
    boundsAnimation.fromValue = @(CGRectGetWidth(_sliderView.layer.bounds));
    boundsAnimation.toValue = @(CGRectGetWidth(item.frame) - space);
    
    // Combine all the animations to a group
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[positionAnimation, boundsAnimation];
    animationGroup.duration = 0.2;
    [_sliderView.layer addAnimation:animationGroup forKey:@"basic"];
    
    // Keep the state after animating
    _sliderView.layer.position = CGPointMake(_sliderView.layer.position.x + dx, _sliderView.layer.position.y);
    CGRect rect = _sliderView.layer.bounds;
    rect.size.width = CGRectGetWidth(item.frame) - space;
    _sliderView.layer.bounds = rect;
}
@end

