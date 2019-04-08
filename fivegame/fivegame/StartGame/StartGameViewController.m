//
//  StartGameViewControllerViewController.m
//  fivegame
//
//  Created by apple on 2019/4/8.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "StartGameViewController.h"

@interface StartGameViewController ()
@property (weak, nonatomic) IBOutlet UIButton *person_mo;
@property (weak, nonatomic) IBOutlet UIButton *person_person_btn;

@end

@implementation StartGameViewController

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
    
}

- (IBAction)personAndperson:(UIButton *)sender {
}

@end
