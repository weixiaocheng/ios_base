//
//  CommonTools.h
//  IOSBASE
//
//  Created by apple on 2019/4/2.
//  Copyright © 2019 corzen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CommonTools : NSObject

/**
 绘制一张纯色的图片

 @param color <#color description#>
 @return <#return value description#>
 */
+ (UIImage *)createImageWithColor: (UIColor *)color;
@end

NS_ASSUME_NONNULL_END
