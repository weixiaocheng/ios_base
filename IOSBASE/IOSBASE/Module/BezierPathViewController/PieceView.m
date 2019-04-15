//
//  PieceView.m
//  IOSBASE
//
//  Created by apple on 2019/4/15.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "PieceView.h"

@implementation PieceView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */


- (void)drawRect:(CGRect)rect {
    [[UIColor whiteColor] setFill];
    UIRectFill(rect);
    [self drawdrawRadialGradientWithRect:rect];
}

- (void)drawdrawRadialGradientWithRect:(CGRect)rect
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSArray *gradientColors = @[(id)RGB16(0xF0F8FF).CGColor, (id)RGB16(0x838B8B).CGColor];
    CGFloat gradientLocaions[] = {0.65, 0.9};
    CGGradientRef dradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocaions);
    CGPoint startCenter = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    CGFloat radius = MAX(CGRectGetHeight(rect), CGRectGetWidth(rect))/2;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawRadialGradient(context, dradient,
                                startCenter, 0,
                                startCenter, radius,
                                0);
    
    NSString *string = @"车";
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setAlignment:NSTextAlignmentCenter];
    NSDictionary *dict = @{
                           NSFontAttributeName : [UIFont systemFontOfSize:28],
                           NSForegroundColorAttributeName : [UIColor blackColor],
                           NSParagraphStyleAttributeName : style
                           };
    CGSize size = [string sizeWithAttributes:dict];
    
    rect.origin.y = CGRectGetMidY(rect) - size.height/2;
    
    [string drawInRect:rect withAttributes:dict];
    
    CGGradientRelease(dradient);
    CGColorSpaceRelease(colorSpace);
}




@end
