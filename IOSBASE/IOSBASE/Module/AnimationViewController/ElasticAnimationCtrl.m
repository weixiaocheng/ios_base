//
//  ElasticAnimationCtrl.m
//  IOSBASE
//
//  Created by apple on 2019/4/4.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "ElasticAnimationCtrl.h"

@interface ElasticAnimationCtrl ()

@end

@implementation ElasticAnimationCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(15, 100, 100, 40);
    btn.backgroundColor = RandColor;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)action: (UIButton *)btn
{

    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
