//
//  YJHotDetail.h
//  Gifts
//
//  Created by yjadair on 15/11/14.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJHotDetail : NSObject

@property (nonatomic, strong) NSString *cover_image_url;

@property (nonatomic, strong) NSString *descriptions;

@property (nonatomic, assign) int favorites_count;

@property (nonatomic, strong) NSArray *image_urls;

@property (nonatomic, strong) NSString *name;

@property (strong, nonatomic) NSString *price;

@property (nonatomic, strong) NSString *purchase_url;

@property (nonatomic, strong) NSString *url;

@property (strong, nonatomic) NSString *ID;

@end
