//
//  WaterFlowLayout.m
//  IOSBASE
//
//  Created by apple on 2019/4/4.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "WaterFlowLayout.h"

@interface WaterFlowLayout ()

@end

static const NSInteger DefaultColumnCount = 3;
static const CGFloat DefaultColumnMargin = 10;
static const CGFloat DefaultRowMargin = 10;
static const UIEdgeInsets DefaultEdgeInsets = {10 , 10 , 10 , 10};

@implementation WaterFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];
    self.sectionCount = 3;
    [self.columnHeights removeAllObjects];
    for (NSInteger i = 0; i < self.columnCount; i ++) {
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }
    
    // 清除之前所有的布局
    [self.attributesArray removeAllObjects];
    for (NSInteger section = 0; section < self.sectionCount; section ++) {
        NSInteger count = [self.collectionView numberOfItemsInSection:section];
        for (NSInteger i = 0; i < count; i ++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:section];
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            [self.attributesArray addObject:attributes];
        }
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat collectionveiwWidth = self.collectionView.frame.size.width;
    CGFloat width = (collectionveiwWidth - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1)*self.columnMargin) / self.columnCount;
    CGFloat height = [self.delegate waterFlowLayout:self heigthForItemAtIndex:indexPath.item itemWidth:width];
    //查找对短的一列
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i < self.columnCount; i++) {
        //第i列高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        if (columnHeight < minColumnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    CGFloat x = self.edgeInsets.left + destColumn*(width + self.columnMargin);
    CGFloat y = minColumnHeight;
    if (y != self.edgeInsets.top) {
        y += self.rowMargin;
    }
    attributes.frame = CGRectMake(x, y, width, height);
    
    //更新最短那列的高度
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attributes.frame));
    return attributes;
}

//返回布局数组
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributesArray;
}

- (CGSize)collectionViewContentSize {
    CGFloat maxColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i < self.columnCount; i++) {
        // 取得第i列的高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        if (maxColumnHeight < columnHeight) {
            maxColumnHeight = columnHeight;
        }
    }
    return CGSizeMake(0, maxColumnHeight + self.edgeInsets.bottom);
}

#pragma 懒加载
- (NSMutableArray *)columnHeights {
    if (!_columnHeights) {
        _columnHeights = [[NSMutableArray alloc]init];
    }
    return _columnHeights;
}

- (NSMutableArray *)attributesArray {
    if (!_attributesArray) {
        _attributesArray = [[NSMutableArray alloc]init];
    }
    return _attributesArray;
}

- (CGFloat)rowMargin {
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterflowLayout:)]) {
        return [self.delegate rowMarginInWaterflowLayout:self];
    } else {
        return DefaultRowMargin;
    }
}

- (CGFloat)columnMargin {
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterflowLayout:)]) {
        return [self.delegate columnMarginInWaterflowLayout:self];
    } else {
        return DefaultColumnMargin;
    }
}

- (NSInteger)columnCount {
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterflowLayout:)]) {
        return [self.delegate columnCountInWaterflowLayout:self];
    } else {
        return DefaultColumnCount;
    }
}

- (UIEdgeInsets)edgeInsets {
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterflowLayout:)]) {
        return [self.delegate edgeInsetsInWaterflowLayout:self];
    } else {
        return DefaultEdgeInsets;
    }
}

@end
