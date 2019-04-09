//
//  PPConnectManager.m
//  fivegame
//
//  Created by apple on 2019/4/9.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "PPConnectManager.h"

static PPConnectManager *manager;

@implementation PPConnectManager
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[PPConnectManager alloc] init];
    });
    return manager;
}
@end
