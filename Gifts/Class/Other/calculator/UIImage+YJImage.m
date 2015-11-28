//
//  UIImage+YJImage.m
//  UI综合—彩票
//
//  Created by yjadair on 15/9/22.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "UIImage+YJImage.h"

@implementation UIImage (YJImage)

+ (instancetype)imageOriginImage:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    image = [UIImage OriginImage:image scaleToSize:CGSizeMake(25, 25)];
    return image;
}

+ (UIImage*)OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    scaledImage = [scaledImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

@end
