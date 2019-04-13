//
//  UIBezierPathView.m
//  IOSBASE
//
//  Created by apple on 2019/4/13.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "UIBezierPathView.h"

@implementation UIBezierPathView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
/*
- (void)drawRect:(CGRect)rect {
    [[UIColor redColor] setFill];
    UIRectFill(CGRectMake(20, 20, 100, 100));
}
*/

/*
- (void)drawRect:(CGRect)rect
{
    [[UIColor whiteColor] setFill];
    UIRectFill(rect); // 填充 充满
    UIColor *color = [UIColor colorWithRed:0 green:0 blue:0.7 alpha:1];
    [color set]; //设置线条颜色
    
    // 画矩形
//    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(20, 20, 100, 50)];
    // 圆形
//    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:50 startAngle:0 endAngle:M_PI*2 clockwise:true];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, 20, 100, 100)];
    path.lineWidth = 8.0;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    [path stroke];
}
 */


/*
 // 这里画了 中国象棋的棋盘
- (void)drawRect:(CGRect)rect
{
    // 底色白色
    [[UIColor whiteColor] setFill];
    UIRectFill(rect); // 填充 充满
    // 计算宽度 正方形的格子
    CGFloat graid_width = (SCREEN_WIDTHL - 80)/8;
    // 开始画棋盘 背景
    [RGB16(0xCD8500) setFill];
    UIRectFill(CGRectMake(20, 20, SCREEN_WIDTHL - 40, graid_width * 9 + 40));
    // 开始画线 绘画中国象棋的棋盘 纵坐标*9 横坐标 10   边距 20
    
    // 开始画外边框
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(40, 40)];
    [path addLineToPoint:CGPointMake(SCREEN_WIDTHL - 40, 40)];
    [path addLineToPoint:CGPointMake(SCREEN_WIDTHL - 40, 40 + graid_width * 9)];
    [path addLineToPoint:CGPointMake(40, 40 + graid_width * 9)];
    [path closePath];
    path.lineWidth = 1;
    [RGB16(0x2B2B2B) set];
    
    // 画横线
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setAlignment:NSTextAlignmentCenter];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    dict[NSParagraphStyleAttributeName] = style;
    for (int i = 0 ; i < 10; i ++) {
        NSString *y = [NSString stringWithFormat:@"%d",i];
        [y drawInRect:CGRectMake(20, 35 + i * graid_width, 20,graid_width) withAttributes:dict];
        [path moveToPoint:CGPointMake(40 , 40 + i * graid_width)];
        [path addLineToPoint:CGPointMake(SCREEN_WIDTHL - 40, 40 + i * graid_width)];
//        [y drawInRect:CGRectMake(SCREEN_WIDTHL - 35, 35 + i * graid_width, 20,graid_width) withAttributes:dict];
    }
    
    // 画竖线
    for (int i = 0; i < 9; i ++) {
        NSString *x = [NSString stringWithFormat:@"%d",i];
        [path moveToPoint:CGPointMake(40 + i * graid_width, 40)];
        [path addLineToPoint:CGPointMake(40 + i * graid_width, 40 + graid_width * 4)];
        
        [path moveToPoint:CGPointMake(40 + i * graid_width, 40 + graid_width * 5)];
        [path addLineToPoint:CGPointMake(40 + i * graid_width, graid_width * 9 + 40)];
        [x drawInRect:CGRectMake(20 + i * graid_width, 20, graid_width,20) withAttributes:dict];
    }
    
    // 上边的 帅
    [path moveToPoint:CGPointMake(40 + graid_width * 3, 40)];
    [path addLineToPoint:CGPointMake(40 + graid_width * 5, 40 + graid_width * 2)];
    [path moveToPoint:CGPointMake(40 + graid_width * 5, 40)];
    [path addLineToPoint:CGPointMake(40 + graid_width * 3, 40 + graid_width * 2)];
    
    // 下边边的 帅
    [path moveToPoint:CGPointMake(40 + graid_width * 3, 40 + graid_width * 9)];
    [path addLineToPoint:CGPointMake(40 + graid_width * 5, 40 + graid_width * 7)];
    [path moveToPoint:CGPointMake(40 + graid_width * 5, 40 + graid_width * 9)];
    [path addLineToPoint:CGPointMake(40 + graid_width * 3, 40 + graid_width * 7)];
    
    // 中间的 楚河 汉界
    NSString *string = @"楚河";
    NSMutableDictionary *textDict = [NSMutableDictionary dictionary];
    textDict[NSFontAttributeName] = [UIFont systemFontOfSize:28];
    textDict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textDict[NSParagraphStyleAttributeName] = style;
    [string drawInRect:CGRectMake(40 , 40 + graid_width * 4, graid_width *4 , graid_width) withAttributes:textDict];
    string = @"汉界";
    [string drawInRect:CGRectMake(40 + graid_width * 4 , 40 + graid_width * 4, 40 + graid_width * 4, 40 + graid_width ) withAttributes:textDict];
    
    // 最后一点 画 坐标符号
    NSArray *arr = @[
                     @[@1,@2],@[@7,@2],@[@0,@3],@[@2,@3],@[@4,@3],@[@6,@3],@[@8,@3],
                     @[@1,@7],@[@7,@7],@[@0,@6],@[@2,@6],@[@4,@6],@[@6,@6],@[@8,@6]
                     ];
    for (int i = 0; i < arr.count; i ++) {
        NSArray *arrItem = arr[i];
        CGPoint point = CGPointMake(40 + [arrItem[0] integerValue]  * graid_width, 40 + [arrItem[1] integerValue] * graid_width);
        if ([arrItem[0] integerValue] > 0) {
            [path moveToPoint:CGPointMake(point.x - 5, point.y - 15)];
            [path addLineToPoint:CGPointMake(point.x - 5, point.y - 5)];
            [path addLineToPoint:CGPointMake(point.x - 15, point.y - 5)];
            
            [path moveToPoint:CGPointMake(point.x - 15, point.y + 5)];
            [path addLineToPoint:CGPointMake(point.x - 5, point.y + 5)];
            [path addLineToPoint:CGPointMake(point.x - 5, point.y + 15)];
        }
        
        if([arrItem[0] integerValue] < 8) {
            [path moveToPoint:CGPointMake(point.x + 5, point.y - 15)];
            [path addLineToPoint:CGPointMake(point.x + 5, point.y - 5)];
            [path addLineToPoint:CGPointMake(point.x + 15, point.y - 5)];
            
            [path moveToPoint:CGPointMake(point.x + 15, point.y + 5)];
            [path addLineToPoint:CGPointMake(point.x + 5, point.y + 5)];
            [path addLineToPoint:CGPointMake(point.x + 5, point.y + 15)];
        }
    }
    
    // 连接起来
    [path stroke];
    
}
*/


/*
- (void)drawRect:(CGRect)rect
{
    // 设置背景颜色为白色
    [[UIColor whiteColor] setFill];
    UIRectFill(rect);
    
    // 画多边形
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 设置第一个点
    path.lineWidth = 5.0;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    
    // 起点
    [path moveToPoint:CGPointMake(20, 20)];
    
    // 绘制线条
    [path addLineToPoint:CGPointMake(200, 40)];
    [path addLineToPoint:CGPointMake(40, 40)];
    [path addLineToPoint:CGPointMake(40, 200)];
    [path addLineToPoint:CGPointMake(20, 200)];
    [path closePath];
    UIColor *color = [UIColor yellowColor];
    [color set];
    UIColor *greenColor = [UIColor greenColor];
    [greenColor setFill];
    [path stroke];
    [path fill];
}
*/

// 放射渐变
- (void)drawRect:(CGRect)rect
{
    [[UIColor whiteColor] setFill];
    UIRectFill(rect);
    [self drawdrawRadialGradientWithRect:CGRectMake(120, 510, 60, 60)];
}

- (void)drawdrawRadialGradientWithRect:(CGRect)rect
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSArray *gradientColors = @[(id)[UIColor whiteColor].CGColor, (id)[UIColor blackColor].CGColor];
    CGFloat gradientLocaions[] = {0, 1};
    CGGradientRef dradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocaions);
    CGPoint startCenter = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    CGFloat radius = MAX(CGRectGetHeight(rect), CGRectGetWidth(rect));
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawRadialGradient(context, dradient,
                                startCenter, 0,
                                startCenter, radius,
                                0);
    
    CGGradientRelease(dradient);
    CGColorSpaceRelease(colorSpace);
}

@end
