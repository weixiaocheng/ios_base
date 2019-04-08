//
//  DynamicElasticViewController.m
//  IOSBASE
//
//  Created by apple on 2019/4/8.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "DynamicElasticViewController.h"

@interface DynamicElasticViewController ()
@property (nonatomic, strong) UIView *actionview; /** < 显示动态的 效果的view */
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UISnapBehavior *snap;
@end

@implementation DynamicElasticViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.actionview = [[UIView alloc] initWithFrame:CGRectMake(40, 100, 40, 40)];
    self.actionview.backgroundColor = RandColor;
    [self.view addSubview:self.actionview];
//    self.actionview.transform = CGAffineTransformMakeRotation(M_PI_4);
    
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.animator = animator;
    _snap = [[UISnapBehavior alloc] initWithItem:self.actionview snapToPoint:self.actionview.center];
    // 4. 将吸附事件添加到仿真者行为中
    [self.animator addBehavior:_snap];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 0. 触摸之前要清零之前的吸附事件，否则动作越来越小
//    [self.animator removeAllBehaviors];
    
    // 1. 获取触摸对象
    UITouch *touch = [touches anyObject];
    
    // 2. 获取触摸点
    CGPoint loc = [touch locationInView:self.view];
    
    NSLog(@"%@", NSStringFromCGPoint(loc));
    // 3 添加吸附事件
    
    _snap.snapPoint = loc;
    // 改变震动幅度，0表示振幅最大，1振幅最小
    _snap.damping = 0.3;

}


@end
