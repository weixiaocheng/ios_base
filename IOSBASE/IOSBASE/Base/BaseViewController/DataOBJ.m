//
//  DataOBJ.m
//  IOSBASE
//
//  Created by apple on 2019/4/1.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "DataOBJ.h"

@implementation DataItemOBJ
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        _name = dict[@"name"];
        _controller_name = dict[@"controller_name"];
    }
    return self;
}

@end

@implementation DataOBJ
- (instancetype)initWithSetcionName:(NSString *)section_name data_list:(NSArray *)dataList
{
    self = [super init];
    if (self) {
        _section_name = section_name;
        NSMutableArray *mutableArr = [NSMutableArray array];
        for (NSDictionary *dict in dataList) {
            DataItemOBJ *data_item_obj = [[DataItemOBJ alloc] initWithDict:dict];
            [mutableArr addObject:data_item_obj];
        }
        _data_list = [mutableArr mutableCopy];
    }
    return self;
}


@end
