//
//  PayViewViewController.m
//  fivegame
//
//  Created by apple on 2019/4/8.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "PayViewViewController.h"
#import "PayManager.h"
#import "../../fivegame/PPPlay/Connect/PPConnectManager.h"
#import <AudioToolbox/AudioToolbox.h>

#define gridCount 15

@interface PayViewViewController ()<PPConnectManagerDelegate>
{
    UIButton *_beganBtn;
}
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGFloat gridWidth ;
@property (nonatomic, strong) PayManager *manager;

@property (nonatomic, strong) UIButton *adServeBtn;
@property (nonatomic, strong) UIButton *searchAdBtn;
@property (nonatomic, strong) PPConnectManager *connectManager;

@end

@implementation PayViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    /*
     设置管理工具
     */
    self.manager = [[PayManager alloc] init];
    self.manager.canBeTap = true;

    self.connectManager = [PPConnectManager shareInstance];
    self.connectManager.delegate = self;
    [self setUpView];
}

- (void)setUpView
{
    self.imageView = [[UIImageView alloc] initWithImage:[self drawImageCheckerboard]];
    [self.view addSubview:self.imageView];
    self.imageView.frame = CGRectMake(15, Height_NavBar + 50, SCREEN_WIDTHL - 30, SCREEN_WIDTHL - 30);
    self.imageView.backgroundColor = RGB16(0xCD9B1D);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapaction:)];
    [self.imageView addGestureRecognizer:tap];
    self.imageView.userInteractionEnabled = true;
    
    UIButton *beganBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    beganBtn.frame = CGRectMake(100, CGRectGetMaxY(self.imageView.frame) + 20, 100, 40);
    [beganBtn addTarget:self action:@selector(beganOnce) forControlEvents:UIControlEventTouchUpInside];
    [beganBtn setTitle:@"开局" forState:UIControlStateNormal];
    _beganBtn = beganBtn;
    [self.view addSubview:beganBtn];
    
    self.adServeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.adServeBtn setTitle:@"发送邀请" forState:UIControlStateNormal];
    [self.view addSubview:self.adServeBtn];
    self.adServeBtn.frame = CGRectMake(100 , CGRectGetMaxY(beganBtn.frame) + 20, 100, 40);
    self.adServeBtn.backgroundColor = RGB16(0x999999);
    [self.adServeBtn addTarget:self.connectManager action:@selector(startServe) forControlEvents:UIControlEventTouchUpInside];
}

- (void)tapaction: (UITapGestureRecognizer *)tap
{
    
    if (self.manager.isWin || self.manager.canBeTap == false ) {
        return;
    }
    
    if (self.manager.isAready == false) {
        [self.view makeToast:@"您自己没有准备好"];
        return;
    }
    
    if (self.manager.matchAready == false) {
        [self.view makeToast:@"您的对手没有准备好"];
        [self.connectManager askIsReady];
        return;
    }
    
    CGPoint point = [tap locationInView:self.imageView];
    NSInteger rol = (point.x - self.gridWidth * 0.5)/self.gridWidth;
    NSInteger cow = (point.y - self.gridWidth * 0.5)/self.gridWidth;
    
    CGPoint piecPoint = CGPointMake(rol, cow);
    
    NSLog(@"\npoint : %@", NSStringFromCGPoint(piecPoint));
    BOOL add_success = [self addPieseWithPoint:piecPoint];
    if (add_success) {
        self.manager.canBeTap = false;
    }
    [self.connectManager sendMessageWithIsBlack:self.manager.isBlack andPoint:piecPoint];
}

#pragma mark -- 添加棋子的坐标
- (BOOL)addPieseWithPoint: (CGPoint)point
{
    //转换成为对应的坐标点
    CGPoint arcPoint = CGPointZero;
    arcPoint.x = (point.x + 0.5) * self.gridWidth;
    arcPoint.y = (point.y + 0.5) * self.gridWidth;
    
    PieceOBJ *piec_obj = [[PieceOBJ alloc] init];
    piec_obj.isBlack = self.manager.isBlack;
    piec_obj.point = point;
    
    if ([self.manager checkIsSuccessWithPieceObj:piec_obj] == false) {
        return false;
    }
    
    UIColor *color = RGB16(0xF7F7F7);
    if (self.manager.isBlack) {
        color = [UIColor blackColor];
    }
    
    [self addLayerFrame:CGRectMake(arcPoint.x + 2.5, arcPoint.y + 2.5, self.gridWidth - 5, self.gridWidth - 5) color:color];
    
    if (self.manager.isWin) {
        [self someBoddyWinWithIsBlack:self.manager.isBlack];
        return false;
    }
    
    self.manager.isBlack = !self.manager.isBlack;
    return true;
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
    self.manager.isAready = false;
    self.manager.matchAready = false;
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
    [_beganBtn setTitle:@"重新开局" forState:UIControlStateNormal];
    self.manager.isBlack = false;
    self.manager.alldownPieces = nil;
    self.manager.isWin = false;
    self.manager.isAready = true;
    
    [self.connectManager sendReady];
    NSMutableArray *layerArr = [self.imageView.layer.sublayers copy];
    
    for (CAShapeLayer *layer in layerArr) {
        [layer removeFromSuperlayer];
    }
}

#pragma mark -- PPConnectManagerDelegate
- (void)showPPAlterCtrl:(UIAlertController *)alertCtrl
{
    self.manager.isAready = true;
    [self presentViewController:alertCtrl animated:true completion:nil];
}

- (void)backPoint:(CGPoint)point withOtherBody:(NSString *)bodyName
{
    self.manager.canBeTap = true;
    dispatch_async(dispatch_get_main_queue(), ^{
       [self addPieseWithPoint:point];
    });
}

- (void)matchIsReady
{
    self.manager.matchAready = true;
}

- (BOOL)getMatchIsReady
{
    if (self.manager.isAready == false) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        dispatch_async(dispatch_get_main_queue(), ^{
           AppDelegateShowToast(@"请准备");
        });
    }
    return self.manager.isAready;
}

@end
