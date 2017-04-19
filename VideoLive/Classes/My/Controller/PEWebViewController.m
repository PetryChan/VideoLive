//
//  PEWebViewController.m
//  VideoLive
//
//  Created by petry(陈荣) on 2017/4/12.
//  Copyright © 2017年 petry(陈荣). All rights reserved.
//

#import "PEWebViewController.h"

#define petry @"https://github.com/PetryChan"

@interface PEWebViewController ()

/** <#description#>  */
@property (nonatomic,strong) UIWebView *webView;

@end

@implementation PEWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self buildWebView];
}

- (void)buildWebView
{
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSURLRequest *res = [NSURLRequest requestWithURL:[NSURL URLWithString:petry]];
    [_webView loadRequest:res];
    [self.view addSubview:_webView];
}

@end
