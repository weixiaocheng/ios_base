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

// 返回发现了代理
- (void)findPeerName: (NSString *)peerName;
@end

@interface PPConnectManager : NSObject
@property (nonatomic, weak)id<PPConnectManagerDelegate>delegate;

@property (nonatomic, strong) MCSession *session;
@property (nonatomic, strong) MCPeerID *peerID;

+ (instancetype)shareInstance;
- (void)startServe;

- (void)sendMessageWithIsBlack: (BOOL) isBlack andPoint: (CGPoint)point;

@end

NS_ASSUME_NONNULL_END
