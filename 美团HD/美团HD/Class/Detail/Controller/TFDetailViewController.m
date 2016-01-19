//
//  TFDetailViewController.m
//  美团HD
//
//  Created by Tengfei on 16/1/18.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "TFDetailViewController.h"
#import "TFDeal.h"
#import "TFConst.h"

@interface TFDetailViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end

@implementation TFDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = MTGlobalBg;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.deail.deal_h5_url]]];
    self.webView.hidden = YES;
    
    //设置基本信息
    self.titleLabel.text = self.deail.title;
    self.subTitleLabel.text = self.deail.desc;
}



-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    NSLog(@"---URL---:%@",request.URL);
    
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.webView.hidden = NO;
    [self.loadingView stopAnimating];
    
//    <html>123</html>
//    innerHTML  123
//    outerHTML    <html>123</html>
    
//    NSString *str = @"document.getElementsByTagName('html')[0].outerHTML";
//    NSString *html = [webView stringByEvaluatingJavaScriptFromString:str];
//    NSLog(@"--html:%@",html);
    
    NSMutableString *js = [NSMutableString string];
    //删除header
    [js appendString:@"var header = document.getElementsByTagName('header')[0];"];
    [js appendString:@"header.parentNode.removeChild(header);"];
    
    //删除购买
    [js appendString:@"var top = document.getElementsByClassName('cost-box')[0];"];
    [js appendString:@"top.parentNode.removeChild(top);"];
    
    //删除header
    [js appendString:@"var bottom = document.getElementsByClassName('buy-now')[0];"];
    [js appendString:@"bottom.parentNode.removeChild(bottom);"];
 
     [webView stringByEvaluatingJavaScriptFromString:js];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 UIInterfaceOrientationUnknown            = UIDeviceOrientationUnknown,
 UIInterfaceOrientationPortrait           = UIDeviceOrientationPortrait,
 UIInterfaceOrientationPortraitUpsideDown = UIDeviceOrientationPortraitUpsideDown,
 UIInterfaceOrientationLandscapeLeft      = UIDeviceOrientationLandscapeRight,
 UIInterfaceOrientationLandscapeRight     = UIDeviceOrientationLandscapeLeft
 
 */


/**
 *  返回控制器的支持的方向
 *
 *  @return
 */
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
