//
//  PayManager.h
//  fivegame
//
//  Created by apple on 2019/4/8.
//  Copyright © 2019 corzen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface PieceOBJ : NSObject
@property (assign, nonatomic)CGPoint point;
@property (assign, nonatomic)BOOL isBlack; /**< 是否为 黑子 */
@property (nonatomic, copy, readonly) NSString *idkey; /**< 棋子的 关键key 用来判断是否 坐标 唯一  */
@end

@interface PayManager : NSObject
@property (nonatomic, strong) NSMutableDictionary *alldownPieces;
@property (nonatomic, assign) BOOL isBlack; /**< 当前为黑子? 默认白子 先走*/

@property (nonatomic, assign) BOOL isWin;
@property (nonatomic, assign) BOOL canBeTap; /**< 能否被点击 */


// 判断当前 局面状态
- (BOOL)checkIsSuccessWithPieceObj: (PieceOBJ *)piceObj;
@end


