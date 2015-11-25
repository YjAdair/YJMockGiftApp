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
#import "YJSliderGiftViewController.h"
#import "YJSliderFoodViewController.h"
#import "YJSliderDigitalViewController.h"
#import "YJSliderGrowTableViewController.h"
#import "YJSliderTitle.h"

#define YJSliderTitleUrl @"http://api.liwushuo.com/v2/channels/preset?gender=1&generation=1"

@interface YJGiftViewController ()<UIScrollViewDelegate>

/*显示礼物说界面内容的Veiw*/
@property (weak, nonatomic) UIScrollView *contentScrollView;
/*select标题*/
@property (nonatomic, weak) UIButton *selButton;
/*标题SV*/
@property (weak, nonatomic) UIScrollView *titleSV;
/*滑块*/
@property (strong, nonatomic) UIView *sliderView;
/*临时显示的View*/
@property (strong, nonatomic) UIView *tempView;
/*临时显示的图片*/
@property (strong, nonatomic) UIImageView *tempImageView;
/*<#name#>*/
@property (strong, nonatomic) NSArray<YJSliderTitle *> *sliderDataArr;
/*<#name#>*/
@property (weak, nonatomic) UIView *subTitleButtonManageView;
/*<#name#>*/
@property (weak, nonatomic) UIView *titleManageView;
/*<#name#>*/
@property (weak, nonatomic) UIView *titleView;
/*<#name#>*/
@property (weak, nonatomic) UIView *board;
/*<#name#>*/
@property (weak, nonatomic) UIButton *moreTitleButton;
@end


@implementation YJGiftViewController

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
        tempImageView.frame = CGRectMake(self.view.yj_width / 2, self.view.yj_height / 2, 60, 60);
        _tempImageView = tempImageView;
    }
    return _tempImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self setupNav];
    //获取sliderTitle
    [self getTitleAFNetworking];
    
}

#pragma mark -设置导航条
- (void)setupNav{
    
    //设置界面标题
    [self.navigationItem setTitleView:[UILabel labelWithSize:20 TitleColor:[UIColor whiteColor] Title:@"礼物说"]];
    //设置navBar右边Item
    UIBarButtonItem *searchItem = [UIBarButtonItem itemWithNorImage:[UIImage imageNamed:@"Feed_SearchBtn"] Target:self Action:@selector(search)];
    UIBarButtonItem *moonNight = [UIBarButtonItem itemWithNorImage:[UIImage imageNamed:@"icon_navigation_nightmode"] Target:self Action:@selector(nightmode)];
    self.navigationItem.rightBarButtonItems = @[searchItem, moonNight];
    
    // iOS7会给导航控制器下所有的UIScrollView顶部添加额外滚动区域
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
        
        NSArray *sliderDataArr = [NSArray array];
        sliderDataArr = [YJSliderTitle mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"channels"]];
        self.sliderDataArr = sliderDataArr;

        // 1.添加所有子控制器
        [self setUpChildViewController];
        
        // 2.初始化ContentScrollView
        [self setUpContentScrollView];
        
        // 3.添加所有子控制器对应标题
        [self setUpTitleLabel:sliderDataArr];
        
        
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
    
    // 海淘
    YJHaiTaoController *haiTao = [[YJHaiTaoController alloc] init];
    [self addChildViewController:haiTao];
    
    // 运动
    YJSportsController *sports = [[YJSportsController alloc] init];
    [self addChildViewController:sports];
    
    //礼物
    YJSliderGiftViewController *gift = [[YJSliderGiftViewController alloc]init];
    [self addChildViewController:gift];
    
    //美食
    YJSliderFoodViewController *food = [[YJSliderFoodViewController alloc]init];
    [self addChildViewController:food];
    
    //数码
    YJSliderDigitalViewController *digital = [[YJSliderDigitalViewController alloc]init];
    [self addChildViewController:digital];
    
    //涨姿势
    YJSliderGrowTableViewController *grow = [[YJSliderGrowTableViewController alloc]init];
    [self addChildViewController:grow];
    
}

#pragma mark 2.添加所有子控制器对应标题
- (void)setUpTitleLabel:(NSArray *)sliderDataArrr{
    
    //创建管理title按钮的View
    [self setupSubTitleButtonManageView];

    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.yj_width, 35)];
    self.titleView = titleView;
    titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleView];
    //创建标题所在ScrollView
    UIScrollView *titleSV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.yj_width, 35)];
    self.titleSV = titleSV;
    titleSV.showsHorizontalScrollIndicator = NO;
    titleSV.showsVerticalScrollIndicator = NO;
    titleSV.backgroundColor = [UIColor whiteColor];
    [titleView addSubview:titleSV];
    //设置标题按钮
    //获取子控制器的个数
    NSInteger count = self.childViewControllers.count;
    //标题最多显示的数目
    int maxShow = 5;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = titleSV.yj_width / maxShow;
    CGFloat btnH = titleSV.yj_height;
//    NSLog(@"%@",self.sliderTitleArr);
    //添加标题
    for (NSInteger i = 0; i < count; i++) {
        YJSliderTitle *title = sliderDataArrr[i];
        //创建标题按钮
        UIButton *titleBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        //设置标题按钮内容
        [titleBtn setTitle:title.name forState:(UIControlStateNormal)];
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
    CGRect temp = titleSV.frame;
    temp.size.width -= btnW;
    titleSV.frame = temp;
    titleSV.contentSize = CGSizeMake(sliderDataArrr.count * btnW, 0);
    
    //获取第一个添加的按钮
    UIButton *firstBtn = [titleSV.subviews firstObject];
    [self setupSliderView:firstBtn];
    [self setupTitleManageViewTitleBtnW:btnW titleBtnH:btnH];
    
    //默认选中第一标题
    [self choiceViewController:firstBtn];
}

#pragma mark -设置滑块
- (void)setupSliderView:(UIButton *)firstButton{
    //立即更新按钮的文字状态，以免设置滑块时，滑块有尺寸和位置却不显示的问题
    [firstButton.titleLabel sizeToFit];
    //创建滑块
    UIView *sliderView = [[UIView alloc]init];
    self.sliderView = sliderView;
    //设置滑块的内容
    sliderView.backgroundColor = [UIColor redColor];
    //设置滑块的初始位置和尺寸
    sliderView.yj_height = 2;
    sliderView.yj_width = firstButton.titleLabel.yj_width;
    sliderView.yj_y = firstButton.yj_height - sliderView.yj_height;
    sliderView.yj_centerX = firstButton.yj_centerX;
    //添加滑块
    [self.titleSV addSubview:sliderView];
}

#pragma mark -创建子标题管理View
- (void)setupSubTitleButtonManageView{
    
    UIView *subTitleButtonManageView = [[UIView alloc]init];
    self.subTitleButtonManageView = subTitleButtonManageView;
    CGFloat manageViewH = YJScreenH - CGRectGetMaxY(self.titleSV.frame) - 49;
    subTitleButtonManageView.frame = CGRectMake(0, - manageViewH, YJScreenW, manageViewH);
    subTitleButtonManageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:subTitleButtonManageView];
    
    UIView *titleManagerSlider = [[UIView alloc]init];
    titleManagerSlider.frame = CGRectMake(0, 0, subTitleButtonManageView.yj_width, 1);
    titleManagerSlider.backgroundColor = [UIColor lightGrayColor];
    [subTitleButtonManageView addSubview:titleManagerSlider];
    
    int maxShowCount = 4;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = (self.subTitleButtonManageView.yj_width  - 10 * (maxShowCount + 1))/ maxShowCount;
    CGFloat btnH = btnW / 3;
    for (int i = 0; i < self.sliderDataArr.count; i++){
        
        YJSliderTitle *subTitle = self.sliderDataArr[i];
        UIButton *subTitleBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [subTitleBtn setTitle:subTitle.name forState:(UIControlStateNormal)];
        [subTitleBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        subTitleBtn.tag = i;
        subTitleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        subTitleBtn.layer.borderWidth = 0.5;
        subTitleBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [subTitleBtn addTarget:self action:@selector(selectedSubTitle:) forControlEvents:(UIControlEventTouchUpInside)];
        btnX = (i % maxShowCount) * (btnW + 10);
        btnY = (i / maxShowCount) * (btnH + 20);
        subTitleBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        subTitleBtn.yj_x += 10;
        subTitleBtn.yj_y += 40;
        [self.subTitleButtonManageView addSubview:subTitleBtn];
    }
    
}

- (void)selectedSubTitle:(UIButton *)subTitleBtn{
    
    [self checkMoreTitle:self.moreTitleButton];
    
    [self choiceViewController:self.titleSV.subviews[subTitleBtn.tag]];
}
#pragma mark -创建标题管理View
- (void)setupTitleManageViewTitleBtnW:(CGFloat)titleBtnW titleBtnH:(CGFloat)titleBtnH{

    //查看更多标题按钮所在的View
    UIView *titleManageView = [[UIView alloc]init];
    self.titleManageView = titleManageView;
    titleManageView.frame = self.titleSV.bounds;
    titleManageView.backgroundColor = [UIColor whiteColor];
    titleManageView.alpha = 0;
    [self.titleSV addSubview:titleManageView];
    
    //查看更多标题按钮
    UIButton *moreTitleButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.moreTitleButton = moreTitleButton;
    [moreTitleButton addTarget:self action:@selector(checkMoreTitle:) forControlEvents:(UIControlEventTouchUpInside)];
    moreTitleButton.frame = CGRectMake(CGRectGetMaxX(self.titleSV.frame), 0, titleBtnW, titleBtnH);
    
    [moreTitleButton setImage:[UIImage OriginImage:[UIImage imageNamed:@"arrow_index_down"] scaleToSize:CGSizeMake(10, 6)] forState:(UIControlStateNormal)];
    [self.titleView addSubview:moreTitleButton];

    //moreTitleButton左边分割线
    UIView *board = [[UIView alloc]init];
    self.board = board;
    board.frame = CGRectMake(CGRectGetMaxX(self.titleSV.frame) + 5, 0, 1, titleBtnH - 20);
    board.yj_centerY = self.titleView.yj_centerY;
    board.backgroundColor = [UIColor lightGrayColor];
    board.alpha = 0.0;
    [self.titleView addSubview:board];
    
    //切换频道按钮
    UIButton *change = [UIButton buttonWithType:(UIButtonTypeCustom)];
    NSString *title = @"切换频道";
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}];
    [change setTitle:title forState:(UIControlStateNormal)];
    change.titleLabel.font = [UIFont systemFontOfSize:14];
    [change setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    change.frame = CGRectMake(20, 0, titleSize.width, titleSize.height);
    change.yj_centerY = self.titleManageView.yj_centerY;
    [self.titleManageView addSubview:change];
    
    //排序或删除按钮
    UIButton *taxisOrDeleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    NSString *taxisOrDeleteTile = @"排序或删除";
    CGSize taxisOrDeleteTileSize = [taxisOrDeleteTile sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]}];
    [taxisOrDeleteBtn setTitle:taxisOrDeleteTile forState:(UIControlStateNormal)];
    taxisOrDeleteBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [taxisOrDeleteBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    taxisOrDeleteBtn.frame = CGRectMake(board.yj_x - 20 - taxisOrDeleteTileSize.width, 0, taxisOrDeleteTileSize.width, taxisOrDeleteTileSize.height);
    taxisOrDeleteBtn.yj_centerY = self.titleManageView.yj_centerY;
    [self.titleManageView addSubview:taxisOrDeleteBtn];
}

#pragma mark -查看更多的标题
- (void)checkMoreTitle:(UIButton *)moreTitleButton{

    [UIView animateWithDuration:0.25 animations:^{
        
        moreTitleButton.transform = CGAffineTransformRotate(moreTitleButton.transform, M_PI);
        self.board.alpha = self.subTitleButtonManageView.yj_y > 0? 0 : 1.0;
        self.titleManageView.alpha = self.subTitleButtonManageView.yj_y > 0? 0 : 1.0;
        self.tabBarController.tabBar.alpha = self.subTitleButtonManageView.yj_y > 0? 1.0 : 0;
        self.subTitleButtonManageView.yj_y = self.subTitleButtonManageView.yj_y > 0? -(YJScreenH - CGRectGetMaxY(self.titleSV.frame) - 49) : 35;
    
    }];
}
#pragma mark -选择子控制器时调用
- (void)choiceViewController:(UIButton *)button{
    
    if ([self.selButton isEqual:button]) return;
    
    // 计算偏移量
    CGFloat offsetX = button.yj_centerX - YJScreenW * 0.5;
    if (offsetX < 0) offsetX = 0;
    
    // 获取最大滚动范围
    CGFloat maxOffsetX = self.titleSV.contentSize.width - self.titleSV.yj_width ;

    if (offsetX > maxOffsetX) offsetX = maxOffsetX;
   
    // 滚动标题滚动条
    [self.titleSV setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
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
    [self.contentScrollView setContentOffset:offset animated:NO];
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
    YJBaseViewController *VC = self.childViewControllers[index];
   
    if ([VC isViewLoaded]) return;
    VC.view.frame = self.contentScrollView.bounds;
    VC.tableView.contentInset = UIEdgeInsetsMake(35 , 0, 49, 0);
    
    VC.sliderTitle = self.sliderDataArr[index];
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

