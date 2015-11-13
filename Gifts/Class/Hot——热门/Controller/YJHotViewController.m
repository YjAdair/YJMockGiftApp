//
//  YJHotViewController.m
//  Gifts
//
//  Created by yjadair on 15/11/8.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJHotViewController.h"
#import "YJHotCell.h"
static NSString *ID = @"hotCell";
@interface YJHotViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
/*<#name#>*/
@property (strong, nonatomic) NSMutableArray *hotItemsImageUrlArr;
/*<#name#>*/
@property (strong, nonatomic) NSMutableArray *hotItemsTitle;
/*<#name#>*/
@property (strong, nonatomic) NSMutableArray *hotItemsPrice;
/*<#name#>*/
@property (strong, nonatomic) NSMutableArray *hotItemsFavorites;
@end

@implementation YJHotViewController
- (NSMutableArray *)hotItemsImageUrlArr{
    if (!_hotItemsImageUrlArr) {
        _hotItemsImageUrlArr = [NSMutableArray array];
    }
    return _hotItemsImageUrlArr;
}
- (NSMutableArray *)hotItemsTitle{
    if (!_hotItemsTitle) {
        _hotItemsTitle = [NSMutableArray array];
    }
    return _hotItemsTitle;
}
- (NSMutableArray *)hotItemsPrice{
    if (!_hotItemsPrice) {
        _hotItemsPrice = [NSMutableArray array];
    }
    return _hotItemsPrice;
}
- (NSMutableArray *)hotItemsFavorites{
    if (!_hotItemsFavorites) {
        _hotItemsFavorites = [NSMutableArray array];
    }
    return _hotItemsFavorites;
}
- (instancetype)init{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    if (self = [super init]) {
        CGFloat itemEdge = 10;
        CGFloat itemW = ([UIScreen mainScreen].bounds.size.width - 3 * itemEdge) / 2;
        CGFloat itemH = 200;
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
    
     [self.navigationItem setTitleView:[UILabel labelWithSize:20 TitleColor:[UIColor whiteColor] Title:@"热门"]];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithNorImage:[UIImage imageNamed:@"Feed_SearchBtn"] Target:self Action:@selector(search)];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"YJHotCell" bundle:nil] forCellWithReuseIdentifier:[YJHotCell ID]];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self getHotItemsData];
}
- (void)search{
    YJNslogFunc
}

- (void)getHotItemsData{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:@"http://api.liwushuo.com/v2/items?gender=1&generation=1&limit=50&offset=0" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSArray *tempHotArr = responseObject[@"data"][@"items"];
        
        for (int i = 0; i < tempHotArr.count; i++) {
            [self.hotItemsImageUrlArr addObject:tempHotArr[i][@"data"][@"cover_image_url"]];
            [self.hotItemsTitle addObject:tempHotArr[i][@"data"][@"name"]];
            [self.hotItemsPrice addObject:tempHotArr[i][@"data"][@"price"]];
            [self.hotItemsFavorites addObject:tempHotArr[i][@"data"][@"favorites_count"]];
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

#pragma mark 每组有多少Item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.hotItemsImageUrlArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YJHotCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];

    cell.collectionImageUrl = self.hotItemsImageUrlArr[indexPath.row];
    cell.collectionTitle = self.hotItemsTitle[indexPath.row];
    cell.collectionPrice = self.hotItemsPrice[indexPath.row];
    cell.collectionFavoritesCount = self.hotItemsFavorites[indexPath.row];
    return cell;
}
@end
