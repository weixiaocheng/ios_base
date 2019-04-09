//
//  PPConnectManager.h
//  fivegame
//
//  Created by apple on 2019/4/9.
//  Copyright © 2019 corzen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class PPConnectManager;
NS_ASSUME_NONNULL_BEGIN

@protocol PPConnectManagerDelegate <NSObject>

- (void)showPPAlterCtrl: (UIAlertController *)alertCtrl;

@end

@interface PPConnectManager : NSObject
@property (nonatomic, weak)id<PPConnectManagerDelegate>delegate;

+ (instancetype)shareInstance;
- (void)startServe;
- (void)startClien;
@end

NS_ASSUME_NONNULL_END
