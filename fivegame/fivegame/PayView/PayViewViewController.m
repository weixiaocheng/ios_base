//
//  PayViewViewController.m
//  fivegame
//
//  Created by apple on 2019/4/8.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "PayViewViewController.h"

#define gridCount 15

@interface PayViewViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGFloat gridWidth ;

@end

@implementation PayViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpView];
    
}

- (void)setUpView
{
    self.imageView = [[UIImageView alloc] initWithImage:[self drawImageCheckerboard]];
    [self.view addSubview:self.imageView];
    self.imageView.frame = CGRectMake(15, Height_NavBar + 50, SCREEN_WIDTHL - 30, SCREEN_WIDTHL - 30);
    self.imageView.backgroundColor = [UIColor yellowColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapaction:)];
    [self.imageView addGestureRecognizer:tap];
    self.imageView.userInteractionEnabled = true;
}

- (void)tapaction: (UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:self.imageView];
    NSLog(@"\npoint : %@", NSStringFromCGPoint(point));
    NSInteger rol = (point.x - self.gridWidth * 0.5)/self.gridWidth;
    NSInteger cow = (point.y - self.gridWidth * 0.5)/self.gridWidth;
    NSLog(@"\nrol : %ld \n cow: %ld", rol, cow);
    
    //转换成为对应的坐标点
    CGPoint arcPoint = CGPointZero;
    arcPoint.x = (rol + 0.5) * self.gridWidth;
    arcPoint.y = (cow + 0.5) * self.gridWidth;
    
    [self addLayerFrame:CGRectMake(arcPoint.x + 2.5, arcPoint.y + 2.5, self.gridWidth - 5, self.gridWidth - 5) color:[UIColor whiteColor]];
    
}

// 画一个标准的棋盘
- (UIImage *)drawImageCheckerboard
{
    CGSize size = CGSizeMake(SCREEN_WIDTHL - 30, SCREEN_WIDTHL - 30);
    
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(ctx, 0.8f);
    
    /*每个格子的宽度*/
    CGFloat gridWidth = size.width/gridCount;
    self.gridWidth = gridWidth;
    /**
     画一个外框
     */
    CGPoint aPoints[4];//坐标点
    aPoints[0] =CGPointMake(0, 0);//坐标1
    aPoints[1] =CGPointMake(size.width, 0);//坐标2
    aPoints[2] =CGPointMake(size.width, size.height);
    aPoints[3] =CGPointMake(0, size.height);
    CGContextAddLines(ctx, aPoints, 5);

    for (int i = 0; i <= gridCount - 1; i ++) {
        CGContextMoveToPoint(ctx,  i * gridWidth + gridWidth , gridWidth);
        CGContextAddLineToPoint(ctx, i * gridWidth + gridWidth , (gridCount - 1) * gridWidth);
    }

    for (int i = 0 ; i <= gridCount - 1; i ++) {
        CGContextMoveToPoint(ctx, gridWidth , gridWidth * i + gridWidth);
        CGContextAddLineToPoint(ctx, gridWidth * (gridCount - 1) ,  i * gridWidth + gridWidth);
    }
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextStrokePath(ctx);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (void)addLayerFrame: (CGRect )frame color: (UIColor *)color
{
    CAShapeLayer *arcLayer = [CAShapeLayer layer];
    CGMutablePathRef path = CGPathCreateMutable();
    arcLayer.fillColor = color.CGColor;
    
    CGPathAddEllipseInRect(path, nil, frame);
    arcLayer.path = path;
    CGPathRelease(path);
    [self.imageView.layer addSublayer:arcLayer];
}



@end
