//
//  DataOBJ.h
//  IOSBASE
//
//  Created by apple on 2019/4/1.
//  Copyright © 2019 corzen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataItemOBJ : NSObject
@property (nonatomic, copy, readonly) NSString *name; /**< <#备注#> */
@property (nonatomic, copy, readonly) NSString *controller_name; /**< <#备注#> */
- (instancetype)initWithDict: (NSDictionary *)dict;
@end

@interface DataOBJ : NSObject
@property (nonatomic, copy, readonly) NSString *section_name; /**< 名称 */
@property (nonatomic, copy, readonly) NSArray *data_list; /**< 列表 */
- (instancetype)initWithSetcionName: (NSString *)section_name data_list: (NSArray *)dataList;
@end


NS_ASSUME_NONNULL_END
