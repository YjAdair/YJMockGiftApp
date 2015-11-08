//
//  UIImage+YJImage.h
//  UI综合—彩票
//
//  Created by yjadair on 15/9/22.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YJImage)
+ (instancetype)imageOriginImage:(NSString *)imageName;
+ (UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size;
@end
