//
//  ButtonController.m
//  IOSBASE
//
//  Created by apple on 2019/4/2.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "ButtonController.h"

@interface ButtonController ()

@end

@implementation ButtonController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
}

- (void)setUpView
{
    UIButton *buton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buton.frame = CGRectMake(100, 100, 100, 40);
    buton.titleLabel.font = [UIFont systemFontOfSize:15];
    [buton setTitle:@"点击" forState:UIControlStateNormal];
    [buton setTitle:@"按下" forState:UIControlStateHighlighted];
    
    [buton setBackgroundImage:[CommonTools createImageWithColor:[UIColor orangeColor]] forState:UIControlStateNormal];
    [buton setBackgroundImage:[CommonTools createImageWithColor:RGB16(0x8831a7)] forState:UIControlStateHighlighted];
    
    /*
     重点切换文字的大小
     */
    NSDictionary *attrDict = @{NSFontAttributeName : [UIFont systemFontOfSize:15],
                               NSForegroundColorAttributeName: RGB16(0x666666)
                               };
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:@"点击" attributes:attrDict];
    [buton setAttributedTitle:attrStr forState:UIControlStateNormal];
    
    NSDictionary *attrSeDict = @{NSFontAttributeName: [UIFont systemFontOfSize:30],
                                 NSForegroundColorAttributeName : RGB16(0x8831A7)
                                 };
    NSAttributedString *attrSeStr = [[NSAttributedString alloc] initWithString:@"按下" attributes:attrSeDict];
    [buton setAttributedTitle:attrSeStr forState:UIControlStateHighlighted];
    
    [self.view addSubview:buton];
    
}

@end
