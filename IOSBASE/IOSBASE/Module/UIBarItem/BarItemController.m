//
//  BarItemController.m
//  IOSBASE
//
//  Created by apple on 2019/4/3.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "BarItemController.h"

@interface BarItemController ()

@end

@implementation BarItemController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *textBarItem = [[UIBarButtonItem alloc] initWithTitle:@"文字" style:UIBarButtonItemStyleDone target:self action:@selector(actionMesg:)];
//    UIBarButtonItem *imageBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"123.png"] style:UIBarButtonItemStylePlain target:self action:@selector(actionMesg:)];
    UIBarButtonItem *sysBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(actionMesg:)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"文字" style:UIBarButtonItemStyleDone target:self action:@selector(actionMesg:)];
   
    
    /*
     如果还是不能满足需要 大部分时间
     */
    UIButton *customeBn = [UIButton buttonWithType:UIButtonTypeCustom];
    [customeBn setTitle:@"自定义" forState:UIControlStateNormal];
    [customeBn setTitleColor:RGB16(0x2b2b2b) forState:UIControlStateNormal];
    [customeBn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customitem = [[UIBarButtonItem alloc] initWithCustomView:customeBn];
//    [self.navigationItem.rightBarButtonItems arrayByAddingObject:customitem];
     self.navigationItem.rightBarButtonItems = @[textBarItem,sysBarItem,customitem];
}

- (void)actionMesg: (UIBarButtonItem *)barItem
{
    NSLog(@"barItem : %@" , barItem);
}

- (void)buttonClicked: (UIButton *)sender
{
    NSLog(@"sender : %@", sender);
}

@end
