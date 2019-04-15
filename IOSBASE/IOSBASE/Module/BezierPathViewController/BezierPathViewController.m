//
//  BezierPathViewController.m
//  IOSBASE
//
//  Created by apple on 2019/4/13.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "BezierPathViewController.h"
#import "UIBezierPathView.h"
#import "PieceView.h"
@interface BezierPathViewController ()
@property (nonatomic, strong) PieceView *pathView;
@end

@implementation BezierPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = false;
    self.pathView  = [[PieceView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    self.pathView.color = [UIColor whiteColor];
    [self.view addSubview:self.pathView];
}



@end
