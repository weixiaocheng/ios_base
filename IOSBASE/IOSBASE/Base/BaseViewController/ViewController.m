//
//  ViewController.m
//  IOSBASE
//
//  Created by apple on 2019/4/1.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "ViewController.h"
#import "ViewManager.h"
#import "DataOBJ.h"
@interface ViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ViewManager *manager;
@end

@implementation ViewController

- (ViewManager *)manager
{
    if (!_manager) {
        _manager = [ViewManager shareInstance];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"iOS 基础";
    [self loadData];
    [self setUpView];
}



#pragma mark -- 加载数据
- (void)loadData
{
    [self.manager loadData];
//    [self.tableView reloadData];
}

#pragma mark -- 加载界面
- (void)setUpView
{
    [self.view addSubview:self.tableView];
}

#pragma mark -- tablewiew
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
  /*知识点
   分割线 顶头
   */
//        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _tableView;
}

#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.manager.data_soure.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DataOBJ *data_obj = self.manager.data_soure[section];
    return data_obj.data_list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"idCell"];
    }
    DataOBJ *data_obj = self.manager.data_soure[indexPath.section];
    DataItemOBJ *item_obj = data_obj.data_list[indexPath.row];
    cell.textLabel.text = item_obj.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:false animated:true];
    
    DataOBJ *data_obj = self.manager.data_soure[indexPath.section];
    DataItemOBJ *item_obj = data_obj.data_list[indexPath.row];
    
    if ([item_obj.name isEqualToString:@"view"]) {
        return;
    }
    // 切换进入对应的界面
    id VCtrl = [[NSClassFromString(item_obj.controller_name) alloc] init];
    [VCtrl setValue:item_obj.name forKey:@"title"];
    [self.navigationController pushViewController:VCtrl animated:true];
}

@end
