//
//  GravityAnimationCtrl.m
//  IOSBASE
//
//  Created by apple on 2019/4/4.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "GravityAnimationCtrl.h"

@interface GravityAnimationCtrl ()

@end

@implementation GravityAnimationCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(15, 100, 100, 40);
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)action: (UIButton *)btn
{
    //    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:4 options:UIViewAnimationOptionAllowUserInteraction animations:^{
    //        CGPoint tempPoint = btn.center;
    //        tempPoint.y += 10;
    //        btn.center=tempPoint;
    //    } completion:^(BOOL finished) {
    //
    //    }];
    shakerAnimation(btn, 2, 20);
    
}

// 重力弹跳动画效果
void shakerAnimation(UIView *view ,NSTimeInterval duration,float height){
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    CGFloat currentTx = view.transform.ty;
    animation.duration = duration;
    animation.values = @[@(currentTx), @(currentTx + height), @(currentTx-height/3*2), @(currentTx + height/3*2), @(currentTx -height/3), @(currentTx + height/3), @(currentTx)];
    animation.keyTimes = @[ @(0), @(0.225), @(0.425), @(0.6), @(0.75), @(0.875), @(1) ];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [view.layer addAnimation:animation forKey:@"kViewShakerAnimationKey"];
}



@end
