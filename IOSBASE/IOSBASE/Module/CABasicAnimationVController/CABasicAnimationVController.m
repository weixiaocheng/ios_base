//
//  CABasicAnimationVController.m
//  IOSBASE
//
//  Created by apple on 2019/4/8.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "CABasicAnimationVController.h"

@interface CABasicAnimationVController ()
@property (nonatomic, strong) UIView *actionview;


@end

@implementation CABasicAnimationVController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.actionview = [[UIView alloc] initWithFrame:CGRectMake(40, 200, 40, 40)];
    self.actionview.backgroundColor = RandColor;
    [self.view addSubview:self.actionview];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"点了一下");
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    moveAnimation.duration = 0.8;
    moveAnimation.fromValue = @(self.actionview.center.y);
    moveAnimation.toValue = @(self.actionview.center.y + 130);
    moveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    moveAnimation.repeatCount = 1;
//    moveAnimation.repeatDuration = 2;
    moveAnimation.removedOnCompletion = NO;
    moveAnimation.fillMode = kCAFillModeForwards;
    [self.actionview.layer addAnimation:moveAnimation forKey:@"fdsa"];
}


@end
