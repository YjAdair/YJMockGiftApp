//
//  YJGiftCellDetail.h
//  Gifts
//
//  Created by yjadair on 15/11/14.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJGiftCellDetail : NSObject

@property (nonatomic, strong) NSString *content_url;

@property (nonatomic, strong) NSString *cover_image_url;

@property (nonatomic, assign) int likes_count;

@property (nonatomic, strong) NSString *share_msg;

@property (nonatomic, strong) NSString *short_title;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *url;

@end
