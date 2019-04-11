//
//  StartGameViewControllerViewController.m
//  fivegame
//
//  Created by apple on 2019/4/8.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "StartGameViewController.h"
#import "../PayView/PayViewViewController.h"
@interface StartGameViewController ()
@property (weak, nonatomic) IBOutlet UIButton *person_mo;
@property (weak, nonatomic) IBOutlet UIButton *person_person_btn;

@end

@implementation StartGameViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:true animated:true];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:false animated:true];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
    // Do any additional setup after loading the view from its nib.
}

- (void)setUpView
{
    self.person_mo.layer.cornerRadius = 5;
    self.person_mo.layer.masksToBounds = true;
    
    self.person_person_btn.layer.cornerRadius = 5;
    self.person_person_btn.layer.masksToBounds = true;
}

- (IBAction)personAndAI:(UIButton *)sender {
    AppDelegateShowToast(@"开发中 敬请期待");
}

- (IBAction)personAndperson:(UIButton *)sender {
    [self.navigationController pushViewController:[PayViewViewController new] animated:true];
}

@end
