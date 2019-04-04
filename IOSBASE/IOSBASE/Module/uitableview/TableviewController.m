//
//  TableviewController.m
//  IOSBASE
//
//  Created by apple on 2019/4/3.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "TableviewController.h"

@interface TableviewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *mutableArray;
@end

@implementation TableviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpview];
}

- (void)setUpview
{
    [self.view addSubview:self.tableview];
    
}

#pragma mark -- 懒加载
- (NSMutableArray *)mutableArray
{
    if (!_mutableArray) {
        _mutableArray = [NSMutableArray array];
    }
    return _mutableArray;
}

- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [UIView new];
        
        WeakSelf;
        _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [weakSelf.mutableArray removeAllObjects];
            [[self mutableArrayValueForKey:@"mutableArray"] removeAllObjects];
            [[self mutableArrayValueForKey:@"mutableArray"] addObject:@[@1,@2,@3,@4,@5,@6,@7,@8,@9]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.tableview.mj_header endRefreshing];
                [weakSelf.tableview reloadData];
            });
            
        }];
        
        _tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
             [[self mutableArrayValueForKey:@"mutableArray"] addObject:@[@1,@2,@3,@4,@5,@6,@7,@8,@9]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.tableview.mj_footer endRefreshing];
                [weakSelf.tableview reloadData];
            });
        }];
        [_tableview.mj_header beginRefreshing];
    }
    return _tableview;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.mutableArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = [self.mutableArray[section] count];
    tableView.mj_footer.hidden = count%9 != 0;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"idCell"];
//        设置字体大小
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        /*自定义的 cell 尽量包含所有的样式 调用的时候 只有type 的区别 这样也会减少卡顿的*/
    }
//    设置文字验证 随机 . 好玩
    cell.textLabel.textColor = RandColor;
    cell.textLabel.text = [NSString stringWithFormat:@"index_section: %ld, index_row: %ld",indexPath.section,(long)indexPath.row];
    BOOL canload = !tableView.dragging&&tableView.decelerating;
    if (canload) {
        NSLog(@"加载图片");
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    /*return UITableViewAutomaticDimension; // 少量情况下可以使用这个*/
    /*
     个人理解在创建这个对象的时候 就计算 高度 这样会好很多
     */
    return 44;
}

@end
