//
//  JWWebViewController.m
//  BagNews
//
//  Created by 微凉 on 16/4/26.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWWebViewController.h"

@interface JWWebViewController ()<UIWebViewDelegate>

@end

@implementation JWWebViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.bounds];
    web.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.view addSubview:web];
    [web loadRequest:request];
    web.scalesPageToFit = YES;

}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    NSString * htmlResponseStr=[NSString stringWithContentsOfURL:[NSURL URLWithString:self.url] encoding:NSUTF8StringEncoding error:Nil];
    NSString *resourcePath = [ [NSBundle mainBundle] resourcePath];
    [[NSFileManager defaultManager] createDirectoryAtPath:[resourcePath stringByAppendingString:@"/Caches"] withIntermediateDirectories:YES attributes:nil error:nil];
    NSString * path=[resourcePath stringByAppendingString:[NSString stringWithFormat:@"/Caches/%lu.html",(unsigned long)[self.url hash]]];
    [htmlResponseStr writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"----%@",path);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
@end
