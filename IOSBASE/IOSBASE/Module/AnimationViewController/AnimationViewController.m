//
//  AnimationViewController.m
//  IOSBASE
//
//  Created by apple on 2019/4/4.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "AnimationViewController.h"

@interface AnimationViewController ()<
UITableViewDelegate,
UITableViewDataSource
>
{
    NSArray *dataList; /*数据源*/
}
@property (nonatomic, strong) UITableView *tableview;

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

- (void)setUpview
{
    [self.view addSubview:self.tableview];
}

- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [UIView new];
    }
    return _tableview;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"idCell"];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = RandColor;
    }
    NSDictionary *dict = dataList[indexPath.row];
    cell.textLabel.text = dict[@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = dataList[indexPath.row];
    id ctrl = [[NSClassFromString(dict[@"className"]) alloc] init];
    [ctrl setValue:dict[@"name"] forKey:@"title"];
    [self.navigationController pushViewController:ctrl animated:true];
}

@end
