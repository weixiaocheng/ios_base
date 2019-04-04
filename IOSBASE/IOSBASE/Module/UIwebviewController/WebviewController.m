//
//  WebviewController.m
//  IOSBASE
//
//  Created by apple on 2019/4/4.
//  Copyright © 2019 corzen. All rights reserved.
//

#import "WebviewController.h"

@interface WebviewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webview;
@end

@implementation WebviewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpView];
}

- (void)setUpView
{
    self.webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webview.delegate = self;
    [self.view addSubview:self.webview];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"oc_html" ofType:@"html"];
//    NSData *data = [NSData dataWithContentsOfFile:path];
    NSLog(@"path : %@",path);
    NSString *htmlstring = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"htmlstring : %@", htmlstring);
    [self.webview loadHTMLString:htmlstring baseURL:[NSURL URLWithString:@"https://www.jianshu.com/p/5c911392308f"]];
}

@end
