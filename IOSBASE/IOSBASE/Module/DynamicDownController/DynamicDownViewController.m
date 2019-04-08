//
//  DynamicDownViewController.m
//  IOSBASE
//
//  Created by apple on 2019/4/4.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "DynamicDownViewController.h"

@interface DynamicDownViewController ()<UIDynamicAnimatorDelegate, UICollisionBehaviorDelegate>
@property (weak, nonatomic) IBOutlet UIView *animatView;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *gravity;
@end

@implementation DynamicDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.animatView.backgroundColor = RandColor;
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.animator.delegate = self;
    self.gravity = [[UIGravityBehavior alloc] initWithItems:@[self.animatView]];
    self.gravity.magnitude = 1;
    //    [gravity setGravityDirection:CGVectorMake(-1, -1)]; // 手动设置x, y
    [self.gravity setAngle:0.5]; // 设置斜率
    
}

- (IBAction)down:(UIButton *)sender {
    self.animatView.frame = CGRectMake(40, 100, 100, 40);
    self.animatView.transform = CGAffineTransformMakeRotation(M_PI_4);
    
    
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] init];
    collision.collisionDelegate = self;
    [collision addItem:self.animatView];
    [collision setTranslatesReferenceBoundsIntoBoundary:YES];
    
    [self.animator addBehavior:collision];
    
    [self.animator addBehavior:self.gravity];
}


- (void)dynamicAnimatorWillResume:(UIDynamicAnimator *)animator
{
    NSLog(@"动画 开始");
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator
{
    NSLog(@"动画结束了");
}

- (void)collisionBehavior:(UICollisionBehavior*)behavior endedContactForItem:(id <UIDynamicItem>)item withBoundaryIdentifier:(nullable id <NSCopying>)identifier
{
    NSLog(@"item : %@",item);
    CGFloat angle = (float)(rand() % 100)/100;
    NSLog(@"angle : %f", angle);
    [self.gravity setAngle: angle];
}

@end
