//
//  PayManager.m
//  fivegame
//
//  Created by apple on 2019/4/8.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "PayManager.h"

@implementation PieceOBJ

- (void)setPoint:(CGPoint)point
{
    _point = point;
    _idkey = [NSString stringWithFormat:@"%2.0f%2.0f",point.x, point.y];
    
}
@end

@implementation PayManager

- (NSMutableDictionary *)alldownPieces
{
    if (!_alldownPieces) {
        _alldownPieces = [NSMutableDictionary dictionary];
    }
    return _alldownPieces;
}

// 判断当前 局面状态
- (BOOL)checkIsSuccessWithPieceObj: (PieceOBJ *)piceObj
{
    // 判断是否已经存在 棋子
    if (self.alldownPieces[piceObj.idkey]) {
        NSLog(@"已经存在一个棋子了")
        return false;
    }
    
    // 添加 新的棋子
    [self.alldownPieces setValue:piceObj forKey:piceObj.idkey];
    
    if (self.alldownPieces.count < 9) {
        return true;
    }
    
    // 开始判断 是否赢了
    /*
     * 当前点坐标 选取 左右 各 个 坐标
     * 小于零 大于 最大值得去掉
     * 当前坐标 选取 上下 个 4 个坐标
     * 小于零 大于 最大值得去掉
     * 选取 斜率 为 1 的 8 个坐标
     * 选取 斜率 为 -1 的 8个坐标
     */
    if ([self checkXAxis:piceObj]) {
        NSLog(@"wining");
        _isWin = true;

    }else if ([self checkYAxis:piceObj]) {
        NSLog(@"wining");
        _isWin = true;

    }else if ([self checkSineAxis:piceObj WithA:[self fromX:piceObj.point.x andY:piceObj.point.y tosinOrcos:1]]) {
        NSLog(@"wining");
        _isWin = true;
        
    }else if ([self checkCosAxis:piceObj WithA:[self fromX:piceObj.point.x andY:piceObj.point.y tosinOrcos:-1]]) {
        NSLog(@"wining");
        _isWin = true;
        
    }
    
    return true;
}

// 关于x轴的判断
- (BOOL)checkXAxis:(PieceOBJ *)piceObj
{
    NSInteger count = 0;
    // 第一轮取值
    for (int i = piceObj.point.x - 4; i <= piceObj.point.x + 4; i ++) {
        if (i < 0) {
            continue;
        }
        NSString *idKey = [NSString stringWithFormat:@"%2d%2.0f", i,piceObj.point.y];
        PieceOBJ *piece_obj = self.alldownPieces[idKey];
        if (!piece_obj) {
            // 为空继续跳过
            count = 0;
            continue;
        }
        
        if (piece_obj.isBlack == piceObj.isBlack) {
            count ++;
        }else{
            count = 0;
        }
        
        if (count >=5) {
            return true;
        }
        
    }
    return false;
}


// 关于Y轴的判断
- (BOOL)checkYAxis:(PieceOBJ *)piceObj
{
    NSInteger count = 0;
    // 第一轮取值
    for (int i = piceObj.point.y - 4; i <= piceObj.point.y + 4; i ++) {
        if (i < 0) {
            continue;
        }
        NSString *idKey = [NSString stringWithFormat:@"%2.0f%2d", piceObj.point.x, i];
        PieceOBJ *piece_obj = self.alldownPieces[idKey];
        if (!piece_obj) {
            // 为空继续跳过
            count = 0;
            continue;
        }
        
        if (piece_obj.isBlack == piceObj.isBlack) {
            count ++;
        }else{
            count = 0;
        }
        
        if (count >=5) {
            return true;
        }
        
    }
    return false;
}

// 关于斜率为1 的判断
- (BOOL)checkSineAxis:(PieceOBJ *)piceObj WithA: (NSInteger )a
{
    NSInteger count = 0;
    // 第一轮取值
    for (int i = piceObj.point.x - 4; i <= piceObj.point.x + 4; i ++) {
        if (i < 0) {
            count = 0;
            continue;
        }
        NSString *idKey = [NSString stringWithFormat:@"%2d%2.0ld", i,(long)[self getYFromX:i andK:a]];
        PieceOBJ *piece_obj = self.alldownPieces[idKey];
        if (!piece_obj) {
            // 为空继续跳过
            count = 0;
            continue;
        }
        
        if (piece_obj.isBlack == piceObj.isBlack) {
            count ++;
        }else{
            count = 0;
        }
        
        if (count >=5) {
            return true;
        }
        
    }
    return false;
}

// 关于斜率为-1 的判断
- (BOOL)checkCosAxis:(PieceOBJ *)piceObj WithA: (NSInteger )a
{
    NSInteger count = 0;
    // 第一轮取值
    for (int i = piceObj.point.x - 4; i <= piceObj.point.x + 4; i ++) {
        if (i < 0) {
            continue;
        }
        NSString *idKey = [NSString stringWithFormat:@"%2d%2.0ld", i,(long)[self getYFromX:-i andK:a]];
        PieceOBJ *piece_obj = self.alldownPieces[idKey];
        if (!piece_obj) {
            // 为空继续跳过
            count = 0;
            continue;
        }

        if (piece_obj.isBlack == piceObj.isBlack) {
            count ++;
        }else{
            count = 0;
        }
        
        if (count >=5) {
            return true;
        }
        
    }
    return false;
}

// 获取平移量 a
- (NSInteger)fromX: (NSInteger)x andY: (NSInteger)y tosinOrcos: (NSInteger)k
{
    if (k == 1) {
        return y + x;
    }else{
        return y - x;
    }
}

- (NSInteger)getYFromX: (NSInteger )x andK: (NSInteger)k
{
    return k - x;
}


@end
