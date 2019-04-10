//
//  PPConnectManager.m
//  fivegame
//
//  Created by apple on 2019/4/9.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "PPConnectManager.h"

static PPConnectManager *manager;

@interface PPConnectManager ()<MCSessionDelegate, MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate>
@property (nonatomic, strong) MCNearbyServiceBrowser *nearbyServiceBrowser;
@property (nonatomic, strong) MCNearbyServiceAdvertiser *nearbyServiceAdveriser;
@property (nonatomic, strong) NSMutableArray *peerIDList;
@property (nonatomic, strong) MCAdvertiserAssistant * advertiser;
@end

@implementation PPConnectManager
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[PPConnectManager alloc] init];
    });
    return manager;
}

- (NSMutableArray *)peerIDList
{
    if (!_peerIDList) {
        _peerIDList = [NSMutableArray array];
    }
    return _peerIDList;
}

- (void)startServe
{
    AppDelegateShowToast(@"开启搜索");
    _peerID = [[MCPeerID alloc] initWithDisplayName:[UIDevice currentDevice].name];
    
    //为用户建立连接
    _session = [[MCSession alloc]initWithPeer:_peerID];
    
    self.session.delegate = self;
    _advertiser = [[MCAdvertiserAssistant alloc]initWithServiceType:@"rsp-receiver" discoveryInfo:nil session:_session];
    //开始广播
    [_advertiser start];
    //设置发现服务(接收方)
    _nearbyServiceBrowser = [[MCNearbyServiceBrowser alloc]initWithPeer:_peerID serviceType:@"rsp-receiver"];
    //设置代理
    _nearbyServiceBrowser.delegate = self;
    [_nearbyServiceBrowser startBrowsingForPeers];
}

#pragma mark -- 发送落子 事件
- (void)sendMessageWithIsBlack:(BOOL)isBlack andPoint:(CGPoint)point
{
    [self sendMessage:NSStringFromCGPoint(point)];
}

#pragma mark -- 发送准备好了
- (void)sendReady
{
    [self sendMessage:AEADY];
}


#pragma mark -- 发送消息
- (void)sendMessage: (NSString *)msg
{
    NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    if (self.peerID == nil) {
        AppDelegateShowToast(@"请先建立连接");
        return;
    }
    
    [self.session sendData:data toPeers:@[self.peerID] withMode:MCSessionSendDataReliable error:&error];
    if (error) {
        NSLog(@"error : %@",error.localizedFailureReason);
    }
}


- (void)browser:(MCNearbyServiceBrowser *)browser foundPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary<NSString *,NSString *> *)info
{
    NSLog(@"\ninfo : %@", peerID);
    // 找到直接连接
    self.peerID = peerID;
    [self.nearbyServiceBrowser invitePeer:self.peerID toSession:self.session withContext:nil timeout:30];
    [browser stopBrowsingForPeers];
}

- (void)browser:(MCNearbyServiceBrowser *)browser lostPeer:(MCPeerID *)peerID
{
    NSLog(@"节点丢失 : %@", peerID.displayName);
    
}

- (void)browser:(MCNearbyServiceBrowser *)browser didNotStartBrowsingForPeers:(NSError *)error
{
    [browser stopBrowsingForPeers];
}

- (void)session:(nonnull MCSession *)session didFinishReceivingResourceWithName:(nonnull NSString *)resourceName fromPeer:(nonnull MCPeerID *)peerID atURL:(nullable NSURL *)localURL withError:(nullable NSError *)error {
    NSLog(@"didFinishReceivingResourceWithName : %@",resourceName);
}

- (void)session:(nonnull MCSession *)session didReceiveData:(nonnull NSData *)data fromPeer:(nonnull MCPeerID *)peerID {
    NSLog(@"didReceiveData : %@",peerID);
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"string: %@",string);
    
    if ([string isEqualToString:AEADY]) {
        if ([self.delegate respondsToSelector:@selector(matchIsReady)]) {
            [self.delegate matchIsReady];
        }
        return;
    }
    
    CGPoint point = CGPointFromString(string);
    if ([self.delegate respondsToSelector:@selector(backPoint:withOtherBody:)]) {
        [self.delegate backPoint:point withOtherBody:peerID.displayName];
    }
}

- (void)session:(nonnull MCSession *)session didReceiveStream:(nonnull NSInputStream *)stream withName:(nonnull NSString *)streamName fromPeer:(nonnull MCPeerID *)peerID {
    NSLog(@"didReceiveStream : %@",streamName);
}

- (void)session:(nonnull MCSession *)session didStartReceivingResourceWithName:(nonnull NSString *)resourceName fromPeer:(nonnull MCPeerID *)peerID withProgress:(nonnull NSProgress *)progress {
     NSLog(@"didStartReceivingResourceWithName : %@",resourceName);
}

- (void)session:(nonnull MCSession *)session peer:(nonnull MCPeerID *)peerID didChangeState:(MCSessionState)state {
    NSLog(@"didChangeState : %@",session);
    switch (state) {
        case MCSessionStateNotConnected:
            NSLog(@"没有连接");
            break;
        case MCSessionStateConnecting:
            NSLog(@"连接中");
            break;
        case MCSessionStateConnected:
            NSLog(@"连接成功");
            if (![self.peerIDList containsObject:peerID]) {
                [self.peerIDList addObject:peerID];
            }
            break;
        default:
            break;
    }
}

- (void)advertiser:(nonnull MCNearbyServiceAdvertiser *)advertiser didReceiveInvitationFromPeer:(nonnull MCPeerID *)peerID withContext:(nullable NSData *)context invitationHandler:(nonnull void (^)(BOOL, MCSession * _Nullable))invitationHandler {
    NSLog(@"didReceiveInvitationFromPeer : %@", invitationHandler);
    [advertiser stopAdvertisingPeer];
    //交互选择框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"%@请求与你建立连接", peerID.displayName] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *accept = [UIAlertAction actionWithTitle:@"接受" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        invitationHandler(YES, self.session);
    }];
    [alert addAction:accept];
    
    UIAlertAction *reject = [UIAlertAction actionWithTitle:@"拒绝" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        invitationHandler(NO, self.session);
    }];
    [alert addAction:reject];
    
    if ([self.delegate respondsToSelector:@selector(showPPAlterCtrl:)]) {
        [self.delegate showPPAlterCtrl:alert];
    }
}

@end
