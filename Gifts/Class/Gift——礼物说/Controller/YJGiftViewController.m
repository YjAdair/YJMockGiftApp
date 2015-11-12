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
#define YJSliderTitleUrl @"http://api.liwushuo.com/v2/channels/preset?gender=1&generation=1"
#define YJSliderTitleSize [UIFont systemFontOfSize:15]
#define YJSliderY 40
#define YJSliderH 2
#define YJSliderColor [UIColor orangeColor];
#define YJTempImageViewW 100
#define YJTempImageViewH YJTempImageViewW
@interface YJGiftViewController ()<UIScrollViewDelegate>

/*显示slider标题的View*/
@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
/*显示礼物说界面内容的Veiw*/
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
/*normal标题*/
@property (weak, nonatomic) UILabel *label;
/*select标题*/
@property (nonatomic, weak) UILabel *selLabel;
/*存储请求slider标题的响应信息*/
@property (strong, nonatomic) NSArray *sliderDataArr;
/*<#name#>*/
@property (strong, nonatomic) NSMutableArray *sliderTitleArr;
/*存储设置好的slider标题*/
@property (nonatomic, strong) NSMutableArray *titleLabels;
/*滑块*/
@property (strong, nonatomic) UIView *sliderView;
/*标题Item的Width和*/
@property (assign, nonatomic) CGFloat total;
/*临时的View*/
@property (weak, nonatomic) UIView *tempView;
@end

@implementation YJGiftViewController

- (NSMutableArray *)titleLabels{
    if (_titleLabels == nil) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}
- (NSMutableArray *)sliderTitleArr{
    if (!_sliderTitleArr) {
        _sliderTitleArr = [NSMutableArray array];
    }
    return _sliderTitleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置界面标题
    [self.navigationItem setTitleView:[UILabel labelWithSize:20 TitleColor:[UIColor whiteColor] Title:@"礼物说"]];
    //设置navBar右边Item
    UIBarButtonItem *nightItem = [UIBarButtonItem itemWithNorImage:[UIImage imageNamed:@"icon_navigation_nightmode"] Target:self Action:@selector(search)];
    UIBarButtonItem *searchItem = [UIBarButtonItem itemWithNorImage:[UIImage imageNamed:@"Feed_SearchBtn"] Target:self Action:@selector(nightmode)];
    self.navigationItem.rightBarButtonItems = @[searchItem, nightItem];
    
    // iOS7会给导航控制器下所有的UIScrollView顶部添加额外滚动区域
    // 不想要添加
    self.automaticallyAdjustsScrollViewInsets = NO;
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
        
        self.sliderDataArr = responseObject[@"data"][@"channels"];

        for (int i = 0; i < self.sliderDataArr.count; i++) {
            [self.sliderTitleArr addObject:self.sliderDataArr[i][@"name"]];
        }
        // 1.添加所有子控制器
        [self setUpChildViewController];
        
        // 2.添加所有子控制器对应标题
        [self setUpTitleLabel];
        
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

#pragma mark  1.添加标题对应的子控制器
- (void)setUpChildViewController{
    // 精选
    YJChoicenessController *choiceness = [[YJChoicenessController alloc] init];
    [self addChildViewController:choiceness];
    
    // 热点
    YJHaiTaoController *haiTao = [[YJHaiTaoController alloc] init];
    [self addChildViewController:haiTao];
    
    // 运动
    YJSportsController *sports = [[YJSportsController alloc] init];
    [self addChildViewController:sports];
    
}

#pragma mark 2.添加所有子控制器对应标题
- (void)setUpTitleLabel{
    //获取当前控制器的子控制器数目
    NSUInteger count = self.childViewControllers.count;
    //设置标题位置和尺寸
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    CGFloat labelH = self.titleScrollView.yj_height;
    for (int i = 0; i < count; i++) {
        
        // 创建label
        UILabel *label = [[UILabel alloc] init];
        self.label = label;
        
        // 设置label文字
        label.text = self.sliderTitleArr[i];
        
        //获取文字宽度
        CGFloat labelW = [self getLabelSize:label.text];
        
        //slider标题的最大X值
        labelX = i * labelW;
        // 设置尺寸
        label.frame = CGRectMake(labelX + space, labelY, labelW, labelH);
        
        // 设置高亮文字颜色
        label.highlightedTextColor = [UIColor redColor];
        
        // 设置label的tag
        label.tag = i;
        
        // 设置用户的交互
        label.userInteractionEnabled = YES;
        
        // 文字居中
        label.textAlignment = NSTextAlignmentCenter;
        label.font = YJSliderTitleSize;

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
            _sliderView = [[UIView alloc]initWithFrame:CGRectMake(space, YJSliderY, labelW, YJSliderH)];
            _sliderView.backgroundColor = YJSliderColor
            [self.titleScrollView addSubview:_sliderView];
        }
    }
    //获取最后一个Item的最大X值
    UILabel *lastLabel = [self.titleLabels lastObject];
    _total = CGRectGetMaxX(lastLabel.frame);
}

#pragma mark 3.初始化UIScrollView
- (void)setUpScrollView{
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

#pragma mark 获取文字宽度
- (CGFloat)getLabelSize:(NSString *)title{
    
    NSDictionary *attributes = @{NSFontAttributeName :YJSliderTitleSize};
    CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return ceil(size.width) + space;
}

#pragma mark 点击标题的时候就会调用
- (void)titleClick:(UITapGestureRecognizer *)tap{
    // 0.获取选中的label
    UILabel *selLabel = (UILabel *)tap.view;
        //0.1 设置滑块的位置
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

#pragma mark 设置标题居中
- (void)setUpTitleCenter:(UILabel *)centerLabel{
    // 计算偏移量
    CGFloat offsetX = centerLabel.center.x - YJScreenW * 0.5;
    
    //当偏移量小于0时，标题不需要居中
    if (offsetX < 0) offsetX = 0;
    
    // 获取最大滚动范围
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - YJScreenW;
    
    if (offsetX > maxOffsetX) offsetX = maxOffsetX;
    
    // 滚动标题滚动条
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
}

#pragma mark - UIScrollViewDelegate
// scrollView一滚动就会调用，给未加载控制器添加一个临时的View
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //未加载控制器的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width + 1;
    if (index <= _titleLabels.count) {
       
        //在未加载控制器的位置添加视图
        [self showUnloadView:index];
    }
    
}
// scrollView——停止滚动时调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //移除临时的View
    [self.tempView removeFromSuperview];
    
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    // 1.添加子控制器view
    [self showVc:index];
    
    // 2.把对应的标题选中
    UILabel *selLabel = self.titleLabels[index];
    [self addAnimationWithSelectedItem:selLabel];
    [self selectLabel:selLabel];
    
    // 3.让选中的标题居中
    [self setUpTitleCenter:selLabel];
    
}

#pragma mark 显示控制器的view
- (void)showVc:(NSInteger)index{
    //获取对应的控制器
    UIViewController *vc = self.childViewControllers[index];
    
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    if (vc.isViewLoaded) return;
    
    //设置控制器的View的位置和尺寸
    CGFloat offsetX = index * YJScreenW;
    vc.view.frame = CGRectMake(offsetX, 0, YJScreenW, YJScreenH);
    
    //将标题对应的控制器添加到内容View上
    [self.contentScrollView addSubview:vc.view];
}

#pragma makr 为未显示控制器的View时添加临时的View
- (void)showUnloadView:(NSInteger)index{

    //获取即将显示的控制器
    UIViewController *vc = self.childViewControllers[index];
    
    //如果控制器的View未加载，就设置一个临时的View
    if (!vc.isViewLoaded) {
        //设置临时的View的位置和尺寸
        CGFloat offsetX = index * YJScreenW;
        UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(offsetX, 0, YJScreenW, YJScreenH)];
        self.tempView = tempView;
        //在临时的View中添加正在加载图片
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, YJTempImageViewW, YJTempImageViewH)];
        imageView.center = CGPointMake(tempView.yj_width / 2, tempView.yj_height / 2);
        imageView.image = [UIImage imageNamed:@"TabBar_gift"];
        [tempView addSubview:imageView];
       
        [self.contentScrollView addSubview:tempView];
    }
}

#pragma mark 设置选中的Item
- (void)selectLabel:(UILabel *)label{
    if (label == self.selLabel) {
        return;
    }
    // 取消之前选中Item高亮
    _selLabel.highlighted = NO;
    // 恢复之前选中Item颜色
    _selLabel.textColor = [UIColor blackColor];
    
    //设置选中Item高亮
    label.highlighted = YES;
    _selLabel = label;
    
}

#pragma mark 设置滑块移动动画
- (void)addAnimationWithSelectedItem:(UILabel *)item {
    // 计算当前选中的item和上一次选中的item的距离
    CGFloat dx = CGRectGetMidX(item.frame) - CGRectGetMidX(_selLabel.frame);

    // 给滑块添加位置动画
    CABasicAnimation *positionAnimation = [CABasicAnimation animation];
    positionAnimation.keyPath = @"position.x";
    positionAnimation.fromValue = @(_sliderView.layer.position.x);
    positionAnimation.toValue = @(_sliderView.layer.position.x + dx);
    
    // 给滑块添加尺寸动画
    CABasicAnimation *boundsAnimation = [CABasicAnimation animation];
    boundsAnimation.keyPath = @"bounds.size.width";
    boundsAnimation.fromValue = @(CGRectGetWidth(_sliderView.layer.bounds));
    boundsAnimation.toValue = @(CGRectGetWidth(item.frame) - space);
    
    // 将位置动画和尺寸动画组合起来
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[positionAnimation, boundsAnimation];
    animationGroup.duration = 0.2;
    [_sliderView.layer addAnimation:animationGroup forKey:@"basic"];
    
    // 保持动画执行完后的滑块状态
    _sliderView.layer.position = CGPointMake(_sliderView.layer.position.x + dx, _sliderView.layer.position.y);
    CGRect rect = _sliderView.layer.bounds;
    rect.size.width = CGRectGetWidth(item.frame) - space;
    _sliderView.layer.bounds = rect;
}
@end

