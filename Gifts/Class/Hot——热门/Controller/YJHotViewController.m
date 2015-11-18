//
//  YJHotViewController.m
//  Gifts
//
//  Created by yjadair on 15/11/8.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJHotViewController.h"
#import "YJHotCell.h"
#import "YJHotDetail.h"
#import "YJHotGiftDetailController.h"
#define YJHotUrl @"http://api.liwushuo.com/v2/items?gender=1&generation=1&limit=50&offset=0"
#define XMGWeakSelf __weak typeof(self) weakSelf = self;

static NSString *ID = @"hotCell";

@interface YJHotViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

/*<#name#>*/
@property (strong, nonatomic) NSMutableArray *hotDetailArr;

/*<#name#>*/
@property (strong, nonatomic) NSString *hotNextUrl;

/*<#name#>*/
@property (weak, nonatomic) AFHTTPSessionManager *manager;
@end

@implementation YJHotViewController

- (NSMutableArray *)hotDetailArr{
    if (!_hotDetailArr) {
        _hotDetailArr = [NSMutableArray array];
    }
    return _hotDetailArr;
}
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (instancetype)init{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    if (self = [super init]) {
        CGFloat itemEdge = 10;
        CGFloat itemW = ([UIScreen mainScreen].bounds.size.width - 3 * itemEdge) / 2;
        CGFloat itemH = 230;
        layout.itemSize = CGSizeMake(itemW, itemH);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
    }

    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [YJHotDetail mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID" : @"id"
                 };
    }];
    
    [self setNav];
    [self setCollectionView];
    [self setupRefresh];
}
- (void)search{
    YJNslogFunc
}
- (void)setNav{
    [self.navigationItem setTitleView:[UILabel labelWithSize:20 TitleColor:[UIColor whiteColor] Title:@"热门"]];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithNorImage:[UIImage imageNamed:@"Feed_SearchBtn"] Target:self Action:@selector(search)];
}
- (void)setCollectionView{
    self.collectionView.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0  blue:239 / 255.0 alpha:1.0];

    [self.collectionView registerNib:[UINib nibWithNibName:@"YJHotCell" bundle:nil] forCellWithReuseIdentifier:[YJHotCell ID]];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

}

#pragma mark -上下刷新
- (void)setupRefresh{
    
    // 下拉刷新
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    
    // 自动改变透明度
    self.collectionView.mj_header.automaticallyChangeAlpha = YES;
    // 马上进入刷新状态
    [self.collectionView.mj_header beginRefreshing];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}
- (void)loadNewTopics{
    
    // 取消之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    // 发送请求
    XMGWeakSelf;
    [self.manager GET:YJHotUrl parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSArray *tempHotArr = responseObject[@"data"][@"items"];
        weakSelf.hotNextUrl = responseObject[@"data"][@"paging"][@"next_url"];
        
        for (int i = 0; i < tempHotArr.count; i++) {
            
            NSDictionary *dict = tempHotArr[i][@"data"];
            YJHotDetail *hotDetail = [YJHotDetail mj_objectWithKeyValues:dict];
            [weakSelf.hotDetailArr addObject:hotDetail];
        }

        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView reloadData];
         weakSelf.collectionView.contentInset = UIEdgeInsetsMake(54, 0, 0, 0);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.collectionView.mj_header endRefreshing];
    }];
}

- (void)loadMoreTopics{
    
    // 取消之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    // 发送请求
    XMGWeakSelf;
    [self.manager GET:self.hotNextUrl parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSArray *tempHotArr = responseObject[@"data"][@"items"];
        weakSelf.hotNextUrl = responseObject[@"data"][@"paging"][@"next_url"];
        
        for (int i = 0; i < tempHotArr.count; i++) {
            
            NSDictionary *dict = tempHotArr[i][@"data"];
            YJHotDetail *hotDetail = [YJHotDetail mj_objectWithKeyValues:dict];
            [weakSelf.hotDetailArr addObject:hotDetail];
            
        }
        
        [weakSelf.collectionView.mj_footer endRefreshing];
        [weakSelf.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.collectionView.mj_footer endRefreshing];
    }];
}
#pragma mark 每组有多少Item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
 
    return self.hotDetailArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YJHotCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    YJHotDetail *hotDetail = self.hotDetailArr[indexPath.row];
    cell.hotDetail = hotDetail;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    YJHotDetail *hotDetail = self.hotDetailArr[indexPath.row];
    YJHotGiftDetailController *giftDetailController = [[YJHotGiftDetailController alloc]init];
    giftDetailController.giftDetailID = hotDetail.ID;
    [self.navigationController pushViewController:giftDetailController animated:YES];
}
@end
