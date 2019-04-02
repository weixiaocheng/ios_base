//
//  CommonTools.m
//  IOSBASE
//
//  Created by apple on 2019/4/2.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "CommonTools.h"

@implementation CommonTools

+ (UIImage *)createImageWithColor: (UIColor *)color
{
    return [self createImageWithColor:color size:CGSizeMake(100, 100)];
}

+ (UIImage *)createImageWithColor: (UIColor *)color size: (CGSize)size
{
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    // 绘制颜色区域
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)];
    
    [color setFill];
    [path fill];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    return image;
}


@end
