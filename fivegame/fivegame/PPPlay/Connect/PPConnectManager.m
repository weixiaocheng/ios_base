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

- (void)startServe
{
    MCPeerID *peerId = [[MCPeerID alloc] initWithDisplayName:[UIDevice currentDevice].name];
    
    self.session = [[MCSession alloc] initWithPeer:peerId securityIdentity:nil encryptionPreference:MCEncryptionRequired];
    
    self.session.delegate = self;
    
    self.nearbyServiceBrowser = [[MCNearbyServiceBrowser alloc] initWithPeer:peerId serviceType:@"rsp-receiver"];
    self.nearbyServiceBrowser.delegate = self;
    [self.nearbyServiceBrowser startBrowsingForPeers];
    NSLog(@"开始服务");
    //广播通知
    self.nearbyServiceAdveriser = [[MCNearbyServiceAdvertiser alloc] initWithPeer:peerId discoveryInfo:nil serviceType:@"rsp-receiver"];
    self.nearbyServiceAdveriser.delegate = self;
    [self.nearbyServiceAdveriser startAdvertisingPeer];
}


- (void)sendMessageWithIsBlack:(BOOL)isBlack andPoint:(CGPoint)point
{
    NSString *string = [NSString stringWithFormat:@"%@",NSStringFromCGPoint(point)];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    [self.session sendData:data toPeers:@[self.peerID] withMode:MCSessionSendDataReliable error:&error];
    if (error) {
        NSLog(@"error : %@",error.localizedFailureReason);
    }
}


- (void)browser:(MCNearbyServiceBrowser *)browser foundPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary<NSString *,NSString *> *)info
{
    NSLog(@"\ninfo : %@", peerID);
    // 找到直接连接
    [browser stopBrowsingForPeers];
    self.peerID = peerID;
    [self.nearbyServiceBrowser invitePeer:self.peerID toSession:self.session withContext:nil timeout:30];
}

- (void)browser:(MCNearbyServiceBrowser *)browser lostPeer:(MCPeerID *)peerID
{
    NSLog(@"节点丢失 : %@", peerID);
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
