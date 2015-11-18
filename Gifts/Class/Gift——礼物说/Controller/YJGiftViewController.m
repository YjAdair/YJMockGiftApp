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

#define YJSliderTitleUrl @"http://api.liwushuo.com/v2/channels/preset?gender=1&generation=1"

@interface YJGiftViewController ()<UIScrollViewDelegate>

/*显示礼物说界面内容的Veiw*/
@property (weak, nonatomic) UIScrollView *contentScrollView;
/*select标题*/
@property (nonatomic, weak) UIButton *selButton;
/*标题SV*/
@property (weak, nonatomic) UIScrollView *titleSV;
/*存储请求slider标题的响应信息*/
@property (strong, nonatomic) NSArray *sliderDataArr;
/*标题文字*/
@property (strong, nonatomic) NSMutableArray *sliderTitleArr;
/*滑块*/
@property (strong, nonatomic) UIView *sliderView;

/*临时显示的View*/
@property (weak, nonatomic) UIView *tempView;
/*<#name#>*/
@property (weak, nonatomic) UIImageView *tempImageView;
@end


@implementation YJGiftViewController

- (NSMutableArray *)sliderTitleArr{
    if (!_sliderTitleArr) {
        _sliderTitleArr = [NSMutableArray array];
    }
    return _sliderTitleArr;
}
- (UIView *)tempView{
    if (!_tempView) {
        UIView *tempView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _tempView = tempView;
        
    }
    return _tempView;
}
- (UIImageView *)tempImageView{
    if (!_tempImageView) {
        UIImageView *tempImageView = [[UIImageView alloc]init];
        tempImageView.image = [UIImage imageNamed:@"PlaceHolderImage_Big"];
        tempImageView.frame = CGRectMake(self.view.yj_width / 2, self.view.yj_height / 2, 100, 100);
        _tempImageView = tempImageView;
    }
    return _tempImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupNav];
    //获取sliderTitle
    [self getTitleAFNetworking];
    
}

#pragma mark -设置导航条
- (void)setupNav{
    //设置界面标题
    [self.navigationItem setTitleView:[UILabel labelWithSize:20 TitleColor:[UIColor whiteColor] Title:@"礼物说"]];
    //设置navBar右边Item
    UIBarButtonItem *nightItem = [UIBarButtonItem itemWithNorImage:[UIImage imageNamed:@"icon_navigation_nightmode"] Target:self Action:@selector(search)];
    UIBarButtonItem *searchItem = [UIBarButtonItem itemWithNorImage:[UIImage imageNamed:@"Feed_SearchBtn"] Target:self Action:@selector(nightmode)];
    self.navigationItem.rightBarButtonItems = @[searchItem, nightItem];
    
    // iOS7会给导航控制器下所有的UIScrollView顶部添加额外滚动区域
    // 不想要添加
    self.automaticallyAdjustsScrollViewInsets = NO;
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
        
        // 2.初始化ContentScrollView
        [self setUpContentScrollView];
        
        // 3.添加所有子控制器对应标题
        [self setUpTitleLabel];
        
        
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
    
    //创建标题所在ScrollView
    UIScrollView *titleSV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.yj_width, 35)];
    self.titleSV = titleSV;
    titleSV.showsHorizontalScrollIndicator = NO;
    titleSV.showsVerticalScrollIndicator = NO;
    titleSV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleSV];
    //设置标题按钮
    //获取子控制器的个数
    NSInteger count = self.childViewControllers.count;
    //标题最多显示的数目
    int maxShow = 5;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = titleSV.yj_width / maxShow;
    CGFloat btnH = titleSV.yj_height;
    //添加标题
    for (NSInteger i = 0; i < count; i++) {
        
        //创建标题按钮
        UIButton *titleBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        //设置标题按钮内容
        [titleBtn setTitle:self.sliderTitleArr[i] forState:(UIControlStateNormal)];
        [titleBtn setTitleColor:[UIColor darkGrayColor] forState:(UIControlStateNormal)];
        [titleBtn setTitleColor:[UIColor redColor] forState:(UIControlStateSelected)];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        //绑定titleBtn的tag
        titleBtn.tag = i;
        //监听标题按钮的点击
        [titleBtn addTarget:self action:@selector(choiceViewController:) forControlEvents:(UIControlEventTouchUpInside)];
        //设置标题按钮的位置和尺寸
        btnX = i * btnW;
        titleBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        //添加标题按钮
        [titleSV addSubview:titleBtn];
    }

    //获取第一个添加的按钮
    UIButton *firstBtn = [titleSV.subviews firstObject];

    //立即更新按钮的文字状态，以免设置滑块时，滑块有尺寸和位置却不显示的问题
    [firstBtn.titleLabel sizeToFit];
    //创建滑块
    UIView *sliderView = [[UIView alloc]init];
    self.sliderView = sliderView;
    //设置滑块的内容
    sliderView.backgroundColor = [UIColor redColor];
    //设置滑块的初始位置和尺寸
    sliderView.yj_height = 2;
    sliderView.yj_width = firstBtn.titleLabel.yj_width;
    sliderView.yj_y = firstBtn.yj_height - sliderView.yj_height;
    sliderView.yj_centerX = firstBtn.yj_centerX;
    //添加滑块
    [titleSV addSubview:sliderView];
    
    //默认选中第一标题
    [self choiceViewController:firstBtn];
}

#pragma mark -选择子控制器时调用
- (void)choiceViewController:(UIButton *)button{
    
    if ([self.selButton isEqual:button]) return;
    
    //取消之前选中的按钮的状态
    self.selButton.selected = NO;
   
    //改变当前选中的按钮的状态
    button.selected = YES;
    self.selButton = button;
    
    //改变滑块的位置和尺寸
    [UIView animateWithDuration:0.25 animations:^{
        self.sliderView.yj_width = button.titleLabel.yj_width;
        self.sliderView.yj_centerX = button.yj_centerX;
    }];
    
    //contentScrollView滚动到需要的显示View的位置
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = self.contentScrollView.yj_width * button.tag;
    [self.contentScrollView setContentOffset:offset animated:YES];
    //添加子控制器的View到contenScrollView
    [self addChildVC];
    
}
#pragma mark 3.初始化UIScrollView
- (void)setUpContentScrollView{
    
    //获取子控制器的数目
    NSInteger count = self.childViewControllers.count;
    
    //设置contentScrollView的位置和尺寸
    UIScrollView *contentScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.contentScrollView = contentScrollView;
    contentScrollView.pagingEnabled = YES;
    contentScrollView.delegate = self;
    contentScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:contentScrollView];
    
    //设置contentScrollView的内容尺寸
    self.contentScrollView.contentSize = CGSizeMake(count * self.view.yj_width, 0);
}

#pragma mark -添加子控制器的View到contentScrollView中
- (void)addChildVC{
    
    //获取需要显示的控制器的索引
    NSInteger index = self.contentScrollView.contentOffset.x / self.contentScrollView.yj_width;
    //获取index对应的子控制器
    UITableViewController *VC = self.childViewControllers[index];
   
    if ([VC isViewLoaded]) return;
    VC.view.frame = self.contentScrollView.bounds;
    VC.tableView.contentInset = UIEdgeInsetsMake(35, 0, 49, 0);
    //添加子控制器的View
    [self.contentScrollView addSubview:VC.view];
}

#pragma mark - UIScrollViewDelegate
// scrollView——停止滚动时调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSUInteger number = scrollView.contentOffset.x / scrollView.yj_width;
    UIButton *button = self.titleSV.subviews[number];
    [self choiceViewController:button];
    
    [self addChildVC];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self.tempView removeFromSuperview];
    [self addChildVC];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger count = scrollView.contentOffset.x / scrollView.yj_width + 1;
    if (count < self.childViewControllers.count) {
        UIViewController *VC = self.childViewControllers[count];
        
        if ([VC isViewLoaded]) return;
    }

    if (count < self.childViewControllers.count ) {
        
        self.tempView.backgroundColor = [UIColor lightGrayColor];
        self.tempView.yj_x = count * scrollView.yj_width;
 
        [self.contentScrollView addSubview:self.tempView];
        
        [self.tempView addSubview:self.tempImageView];
    }
}
@end

