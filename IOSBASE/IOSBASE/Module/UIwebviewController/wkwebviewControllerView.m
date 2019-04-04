//
//  wkwebviewControllerViewController.m
//  IOSBASE
//
//  Created by apple on 2019/4/4.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "wkwebviewControllerView.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <WebKit/WebKit.h>

#define HttpUrl @"http://192.168.100.9/html/Template_1.html"
@interface wkwebviewControllerView ()<WKUIDelegate, WKNavigationDelegate,WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *webview;
@end

@implementation wkwebviewControllerView
/*
 有关 oc 调用js 方法
 - (void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))completionHandler;
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
}

- (void)setUpView
{
    [self.view addSubview:self.webview];
    NSURL *url = [NSURL URLWithString:HttpUrl];
    NSString *htmlString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    [self.webview loadHTMLString:htmlString baseURL:url];
}

#pragma mark -- 懒加载
- (WKWebView *)webview
{
    if (!_webview) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *userController = [[WKUserContentController alloc] init];
        config.userContentController = userController;
        [config.userContentController addScriptMessageHandler:self name:@"img_click"];
        _webview = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
        _webview.UIDelegate = self;
        _webview.navigationDelegate = self;
    }
    return _webview;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"加载完毕网页");
    
    NSString *string = @"img_click('name')";
    [self.webview evaluateJavaScript:string completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"result : %@, \n error: %@", result, error);
    }];

   
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"\nmessage_name : %@ \nmessage_body : %@\n", message.name, message.body);
}


@end
