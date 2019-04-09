//
//  PayViewViewController.m
//  fivegame
//
//  Created by apple on 2019/4/8.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "PayViewViewController.h"
#import "PayManager.h"
#define gridCount 15

@interface PayViewViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGFloat gridWidth ;
@property (nonatomic, strong) PayManager *manager;
@end

@implementation PayViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.manager = [[PayManager alloc] init];
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
    
    UIButton *beganBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    beganBtn.frame = CGRectMake(100, CGRectGetMaxY(self.imageView.frame) + 20, 100, 40);
    [beganBtn addTarget:self action:@selector(beganOnce) forControlEvents:UIControlEventTouchUpInside];
    [beganBtn setTitle:@"重新开局" forState:UIControlStateNormal];
    
    [self.view addSubview:beganBtn];
    
}

- (void)tapaction: (UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:self.imageView];
//    NSLog(@"\npoint : %@", NSStringFromCGPoint(point));
    NSInteger rol = (point.x - self.gridWidth * 0.5)/self.gridWidth;
    NSInteger cow = (point.y - self.gridWidth * 0.5)/self.gridWidth;
//    NSLog(@"\nrol : %ld \n cow: %ld", rol, cow);
    
    //转换成为对应的坐标点
    CGPoint arcPoint = CGPointZero;
    arcPoint.x = (rol + 0.5) * self.gridWidth;
    arcPoint.y = (cow + 0.5) * self.gridWidth;
    
    PieceOBJ *piec_obj = [[PieceOBJ alloc] init];
    piec_obj.isBlack = self.manager.isBlack;
    piec_obj.point = CGPointMake(rol, cow);
    
    if ([self.manager checkIsSuccessWithPieceObj:piec_obj] == false) {
        return;
    }
    
   
    
    UIColor *color = [UIColor whiteColor];
    if (self.manager.isBlack) {
        color = [UIColor blackColor];
    }
    
    [self addLayerFrame:CGRectMake(arcPoint.x + 2.5, arcPoint.y + 2.5, self.gridWidth - 5, self.gridWidth - 5) color:color];
    
    if (self.manager.isWin) {
        [self someBoddyWinWithIsBlack:self.manager.isBlack];
        return;
    }
    
    self.manager.isBlack = !self.manager.isBlack;
    
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


- (void)someBoddyWinWithIsBlack: (BOOL)isBlack
{
    NSString *message = isBlack? @"黑子胜利✌️!" : @"白子胜利✌️!";
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了确定");
    }];
    
    UIAlertAction *onceAngen = [UIAlertAction actionWithTitle:@"再战一局" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了再来");
        [self beganOnce];
    }];
    
    [alertCtrl addAction:sure];
    [alertCtrl addAction:onceAngen];
    [self presentViewController:alertCtrl animated:true completion:nil];
}

- (void)beganOnce
{
    self.manager.isBlack = false;
    self.manager.alldownPieces = nil;
    self.manager.isWin = false;
    NSMutableArray *layerArr = [self.imageView.layer.sublayers copy];
    
    for (CAShapeLayer *layer in layerArr) {
        [layer removeFromSuperlayer];
    }
}

@end
