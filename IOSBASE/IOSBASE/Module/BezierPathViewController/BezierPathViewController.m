//
//  BezierPathViewController.m
//  IOSBASE
//
//  Created by apple on 2019/4/13.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "BezierPathViewController.h"
#import "UIBezierPathView.h"
@interface BezierPathViewController ()
@property (nonatomic, strong) UIBezierPathView *pathView;
@end

@implementation BezierPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = false;
    self.pathView  = [[UIBezierPathView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.pathView];
}

- (void)drawBackView
{
    
}

@end
