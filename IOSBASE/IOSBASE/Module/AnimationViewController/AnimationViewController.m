//
//  AnimationViewController.m
//  IOSBASE
//
//  Created by apple on 2019/4/4.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "AnimationViewController.h"
#import "TableView.h"
@interface AnimationViewController ()<KCTableViewDelegate>
{
    NSArray *dataList; /*数据源*/
}
@property (nonatomic, strong) TableView *tableview;

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self setUpview];
    
    // Do any additional setup after loading the view.
}

- (void)loadData
{
    dataList = @[
  @{@"name": @"重力动画", @"className" : @"GravityAnimationCtrl"},
  @{@"name": @"弹力动画", @"className" : @"ElasticAnimationCtrl"},
                 ];
}

- (TableView *)tableview
{
    if (!_tableview) {
        _tableview = [[TableView alloc] initWithFrame:self.view.bounds];
        _tableview.delegate = self;
    }
    return _tableview;
}

- (void)setUpview
{
    [self.view addSubview:self.tableview];
}

- (NSInteger)TableView: (TableView *)tableview numberOfSection: (NSInteger)section
{
    return dataList.count;
}

- (NSString *)TableView: (TableView *)tableview nameOfCelltext: (NSIndexPath *)indexPath
{
    NSDictionary *dict = dataList[indexPath.row];
    return dict[@"name"];
}

- (void)TableView: (TableView *)tableview didSelectCellIndexPath: (NSIndexPath *)indexPath
{
    NSDictionary *dict = dataList[indexPath.row];
    id ctrl = [[NSClassFromString(dict[@"className"]) alloc] init];
    [ctrl setValue:dict[@"name"] forKey:@"title"];
    [self.navigationController pushViewController:ctrl animated:true];
}

@end
