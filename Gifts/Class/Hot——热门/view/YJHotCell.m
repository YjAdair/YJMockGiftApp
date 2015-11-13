//
//  YJHotCell.m
//  Gifts
//
//  Created by yjadair on 15/11/13.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJHotCell.h"
@interface YJHotCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
/*<#name#>*/
@property (strong, nonatomic) NSMutableArray *collectionIconData;
@end
@implementation YJHotCell

- (NSMutableArray *)collectionIconData{
    if (!_collectionIconData) {
        _collectionIconData = [NSMutableArray array];
    }
    return _collectionIconData;
}
+ (NSString *)ID{
    return @"hotCell";
}
+ (YJHotCell *)hotCell{
    return [[NSBundle mainBundle] loadNibNamed:@"YJHotCell" owner:nil options:nil][0];
}

- (void)setCollectionImageUrl:(NSString *)collectionImageUrl{
    _collectionImageUrl = collectionImageUrl;
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager GET:collectionImageUrl parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                self.icon.image = [UIImage imageWithData:responseObject];
            
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            
        }];
}
- (void)setCollectionTitle:(NSString *)collectionTitle{
    _collectionTitle = collectionTitle;
    self.title.text = collectionTitle;
}
- (void)setCollectionPrice:(NSString *)collectionPrice{
    _collectionPrice = collectionPrice;
    self.money.text = [NSString stringWithFormat:@"￥%@", collectionPrice];
}
- (void)setCollectionFavoritesCount:(NSNumber *)collectionFavoritesCount{
    _collectionFavoritesCount = collectionFavoritesCount;
    self.likeCount.text = collectionFavoritesCount.stringValue;
}
@end
