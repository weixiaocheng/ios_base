//
//  DynamicDownViewController.m
//  IOSBASE
//
//  Created by apple on 2019/4/4.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "DynamicDownViewController.h"

@interface DynamicDownViewController ()
@property (weak, nonatomic) IBOutlet UIView *animatView;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@end

@implementation DynamicDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.animatView.backgroundColor = RandColor;
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
}

- (IBAction)down:(UIButton *)sender {
    self.animatView.transform = CGAffineTransformMakeRotation(M_PI_4);
    
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.animatView]];
    gravity.magnitude = 1;
//    [gravity setGravityDirection:CGVectorMake(-1, -1)]; // 手动设置x, y
    [gravity setAngle:0.5]; // 设置斜率
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] init];
    [collision addItem:self.animatView];
    [collision setTranslatesReferenceBoundsIntoBoundary:YES];
    
    [self.animator addBehavior:collision];
    
    [self.animator addBehavior:gravity];
}


@end
