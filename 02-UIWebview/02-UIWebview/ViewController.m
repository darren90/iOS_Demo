//
//  ViewController.m
//  02-UIWebview
//
//  Created by Fengtf on 15/7/14.
//  Copyright (c) 2015年 rrmj. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()<UIWebViewDelegate>
    
@property (nonatomic,weak)UIWebView * webView;
    
@property (nonatomic,assign)BOOL didWebViewLoadOK;
    
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initWebView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(begainFullScreen) name:UIWindowDidBecomeVisibleNotification object:nil];//进入全屏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endFullScreen) name:UIWindowDidBecomeHiddenNotification object:nil];//退出全屏
}

#pragma - mark  进入全屏
-(void)begainFullScreen
{
    if(!self.didWebViewLoadOK) {
        return;
    }
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = YES;
    
    [[UIDevice currentDevice] setValue:@"UIInterfaceOrientationLandscapeLeft" forKey:@"orientation"];
    
    //强制zhuan'p：
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationLandscapeLeft;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}
    
    
#pragma - mark 退出全屏
-(void)endFullScreen
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = NO;
    
    //强制归正：
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val =UIInterfaceOrientationPortrait;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

/**
 *  初始化webView
 */
-(void)initWebView{
    UIWebView *webView = [[UIWebView alloc]init];
    self.webView = webView;
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    webView.delegate = self;
    
    self.webView.mediaPlaybackRequiresUserAction = YES;
    //http://tv.sohu.com/20150713/n416636681.shtml
    NSURL *url = [NSURL URLWithString: @"http://www.iqiyi.com/v_19rron8psw.html?src=focustext_2_20130410_1#curid=378627300_481ef4234d04240f8e3526ba4d503a1d"];
    url = [NSURL URLWithString:@"https://v.qq.com/x/cover/j6cgzhtkuonf6te.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request ];
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@":%@----:%ld",request.URL,(long)navigationType);
    
    //防止调回视频对应的客户端
    NSString *urlStr = request.URL.absoluteString;
    if ([urlStr rangeOfString:@"sohuvideo:"].location != NSNotFound //拦截搜狐
        || [urlStr rangeOfString:@"action.cmd"].location != NSNotFound) {
        return NO;
    }else{
        return YES;
    }
}
 
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    self.didWebViewLoadOK = YES;
}
    
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    self.didWebViewLoadOK = NO;
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
