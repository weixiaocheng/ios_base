//
//  ViewManager.h
//  IOSBASE
//
//  Created by apple on 2019/4/1.
//  Copyright © 2019 corzen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewManager : NSObject
@property (nonatomic, copy) NSArray *data_soure;

+ (instancetype)shareInstance; 

// 获取pilist 数据
- (void)loadData;
@end

NS_ASSUME_NONNULL_END
