//
//  LabelViewController.m
//  IOSBASE
//
//  Created by apple on 2019/4/1.
//  Copyright © 2019 corzen. All rights reserved.
//

/** 知识点总结
 * 1. 基本的 : 颜色 大小 
 * 2. attribute 变化大小 , 颜色 字体 , 上划线 中划线 下划线 
 */
#import "LabelViewController.h"

@interface LabelViewController ()

@end

@implementation LabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
}

- (void)setUpView
{
    WeakSelf;
    /*
     1. 显示 基本使用
     */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 40)];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).offset(BaseMarginSize);
        make.right.equalTo(weakSelf.view).offset(-BaseMarginSize);
        make.top.equalTo(weakSelf.view).offset(Height_TopBar + BaseMarginSize);
    }];
    
    label.text = @"1. 字体大小 15 \n2. 字体颜色: red\n3. 支持换行";
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:15];
    label.numberOfLines = 0;
    
    /*
     2. 可变字体
     */
    UILabel *labelAttur = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.view addSubview:labelAttur];
    [labelAttur mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(label);
        make.top.equalTo(label.mas_bottom).offset(KCAdaptedWidth(15));
    }];
    NSMutableDictionary *attureDict = [NSMutableDictionary dictionary];
    attureDict[NSForegroundColorAttributeName] = [UIColor orangeColor];
    attureDict[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    labelAttur.attributedText = [[NSAttributedString alloc] initWithString:@"4. 这里显示AttriButes" attributes:attureDict];
    
    /*
     3. 显示前后颜色字体不一样
     */
    UILabel *labelAttur2 = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.view addSubview:labelAttur2];
    [labelAttur2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(labelAttur);
        make.top.equalTo(labelAttur.mas_bottom).offset(KCAdaptedWidth(15));
    }];
    NSString *string = @"5. 显示前后颜色字体不一样";
    NSMutableAttributedString *mutablleAttString = [[NSMutableAttributedString alloc] initWithString:string];
    [mutablleAttString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, 3)];
    [mutablleAttString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
    [mutablleAttString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(3, 2)];
    [mutablleAttString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(3, 2)];
    labelAttur2.attributedText = mutablleAttString;
    
    /*
     * 4. 这里玩划线文化
     */
    UILabel *scribingLB = [[UILabel alloc] initWithFrame:CGRectZero];
    string = @"6. 这里显示划线 下划线 中划线";
    [self.view addSubview:scribingLB];
    [scribingLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(labelAttur2);
        make.top.equalTo(labelAttur2.mas_bottom).offset(KCAdaptedWidth(15));
    }];
    NSMutableAttributedString *mutableAttri = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange bottomRange = [string rangeOfString:@"下划线"];
    [mutableAttri addAttributes:@{
                                  NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),
                                  NSUnderlineColorAttributeName: [UIColor redColor],
                                  }range:bottomRange];
    NSRange strikRange = [string rangeOfString:@"中划线"];
//    [mutableAttri addAttributes:@{
//                                  NSStrokeColorAttributeName: [UIColor greenColor],
//                                  NSStrokeWidthAttributeName: @30,
//                                  } range:strikRange];
    [mutableAttri addAttributes:@{
                                  NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle),
                                  NSStrikethroughColorAttributeName: [UIColor redColor]
                                  } range:strikRange];
    
    scribingLB.attributedText = mutableAttri;
    
    /*
     5. 还可以加入图片
     */
    
}


@end
