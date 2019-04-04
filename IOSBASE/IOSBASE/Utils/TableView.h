//
//  TableView.h
//  IOSBASE
//
//  Created by apple on 2019/4/4.
//  Copyright © 2019 corzen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TableView;

@protocol KCTableViewDelegate <NSObject>


/**
 代理返回 每个section

 @param tableview <#tableview description#>
 @param section <#section description#>
 @return <#return value description#>
 */
- (NSInteger)TableView: (TableView *)tableview numberOfSection: (NSInteger)section;


/**
 返回 cell.textlabel 需要显示的text

 @param tableview <#tableview description#>
 @param indexPath <#indexPath description#>
 @return <#return value description#>
 */
- (NSString *)TableView: (TableView *)tableview nameOfCelltext: (NSIndexPath *)indexPath;



/**
 点击cell 的事件

 @param tableview <#tableview description#>
 @param indexPath <#indexPath description#>
 */
- (void)TableView: (TableView *)tableview didSelectCellIndexPath: (NSIndexPath *)indexPath;


@end

@interface TableView : UIView
@property (nonatomic, weak)id<KCTableViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
