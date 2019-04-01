//
//  ViewManager.m
//  IOSBASE
//
//  Created by apple on 2019/4/1.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "ViewManager.h"
#import "DataOBJ.h"
static ViewManager *manager;
@implementation ViewManager

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[super alloc] init];
    });
    return manager;
}

- (void)loadData
{
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"base_list.plist" ofType:nil];
    NSLog(@"path : %@", path);
    
    // 获取数组
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSLog(@"array : %@", array);
    
    // 遍历生成对象
    NSMutableArray *muarray = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        DataOBJ *data_obj = [[DataOBJ alloc] initWithSetcionName:dict[@"section_name"] data_list:dict[@"data_list"]];
        [muarray addObject:data_obj];
    }
    self.data_soure = [muarray mutableCopy];
}
@end
