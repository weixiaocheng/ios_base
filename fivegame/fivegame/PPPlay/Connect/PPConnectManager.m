//
//  PPConnectManager.m
//  fivegame
//
//  Created by apple on 2019/4/9.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "PPConnectManager.h"
#import <MultipeerConnectivity/MultipeerConnectivity.h>
static PPConnectManager *manager;

@interface PPConnectManager ()<MCSessionDelegate, MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate>
@property (nonatomic, strong) MCSession *session;
@property (nonatomic, strong) MCNearbyServiceBrowser *nearbyServiceBrowser;
@property (nonatomic, strong) MCNearbyServiceAdvertiser *nearbyServiceAdveriser;
@property (nonatomic, strong) MCPeerID *peerID;
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
}

- (void)startClien
{
    MCPeerID *peerID = [[MCPeerID alloc] initWithDisplayName:[UIDevice currentDevice].name];
    self.session = [[MCSession alloc] initWithPeer:peerID securityIdentity:nil encryptionPreference:MCEncryptionRequired];
    self.session.delegate = self;
    
    //广播通知
    self.nearbyServiceAdveriser = [[MCNearbyServiceAdvertiser alloc] initWithPeer:peerID discoveryInfo:nil serviceType:@"rsp-receiver"];
    self.nearbyServiceAdveriser.delegate = self;
    [self.nearbyServiceAdveriser startAdvertisingPeer];
    NSLog(@"开始搜索");
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
