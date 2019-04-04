//
//  WaterFlowLayout.h
//  IOSBASE
//
//  Created by apple on 2019/4/4.
//  Copyright © 2019 corzen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class WaterFlowLayout;
@protocol WaterFlowLayoutDelegate <NSObject>

@required
//获取每个cell的高度
- (CGFloat)waterFlowLayout:(WaterFlowLayout *)waterFlowLayout heigthForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional
- (CGFloat)columnCountInWaterflowLayout:(WaterFlowLayout *)waterflowLayout;
- (CGFloat)columnMarginInWaterflowLayout:(WaterFlowLayout *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(WaterFlowLayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(WaterFlowLayout *)waterflowLayout;
@end
@interface WaterFlowLayout : UICollectionViewLayout
@property (nonatomic, weak)id<WaterFlowLayoutDelegate>delegate;

@property (nonatomic, strong) NSMutableArray *columnHeights;
@property (nonatomic, strong) NSMutableArray *attributesArray;
@property (nonatomic, assign) CGFloat rowMargin;
@property (nonatomic, assign) CGFloat columnMargin;
@property (nonatomic, assign) NSInteger columnCount;
@property (nonatomic, assign) UIEdgeInsets edgeInsets;
@property (nonatomic, assign) CGFloat sectionCount;
@end

NS_ASSUME_NONNULL_END
