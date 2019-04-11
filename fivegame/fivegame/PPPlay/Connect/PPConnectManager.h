//
//  PPConnectManager.h
//  fivegame
//
//  Created by apple on 2019/4/9.
//  Copyright © 2019 corzen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>
@class PPConnectManager;
NS_ASSUME_NONNULL_BEGIN

@protocol PPConnectManagerDelegate <NSObject>

- (void)showPPAlterCtrl: (UIAlertController *)alertCtrl;

// 接受对方 返回的棋子
- (void)backPoint: (CGPoint)point withOtherBody: (NSString *)bodyName;

// 对手准备好了
- (void)matchIsReady;

// 对手是否准备好了
- (BOOL)getMatchIsReady;

@end

@interface PPConnectManager : NSObject
@property (nonatomic, weak)id<PPConnectManagerDelegate>delegate;

@property (nonatomic, strong) MCSession *session;
@property (nonatomic, strong) MCPeerID *peerID;

+ (instancetype)shareInstance;
- (void)startServe;


/**
 发生坐标

 @param isBlack <#isBlack description#>
 @param point <#point description#>
 */
- (void)sendMessageWithIsBlack: (BOOL) isBlack andPoint: (CGPoint)point;


/**
 发送准备好了
 */
- (void)sendReady;

- (void)askIsReady;

@end

NS_ASSUME_NONNULL_END
