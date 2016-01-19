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
#import "DPAPI.h"
#import "MBProgressHUD+MJ.h"
#import "MTRestrictions.h"
#import "MJExtension.h"
//#import "<#header#>"

@interface TFDetailViewController ()<UIWebViewDelegate,DPRequestDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
- (IBAction)buy;
- (IBAction)collect;
- (IBAction)share;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;
@property (weak, nonatomic) IBOutlet UIButton *refundableAnyTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *refundableExpireButton;
@property (weak, nonatomic) IBOutlet UIButton *leftTimeButton;
@end

@implementation TFDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = MTGlobalBg;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.deal.deal_h5_url]]];
    self.webView.hidden = YES;
    
    //设置基本信息
    self.titleLabel.text = self.deal.title;
    self.subTitleLabel.text = self.deal.desc;
    
    // 设置剩余时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *dead = [fmt dateFromString:self.deal.purchase_deadline];
    // 追加1天
    dead = [dead dateByAddingTimeInterval:24 * 60 * 60];
    NSDate *now = [NSDate date];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *cmps = [[NSCalendar currentCalendar] components:unit fromDate:now toDate:dead options:0];
    if (cmps.day > 365) {
        [self.leftTimeButton setTitle:@"一年内不过期" forState:UIControlStateNormal];
    } else {
        [self.leftTimeButton setTitle:[NSString stringWithFormat:@"%d天%d小时%d分钟", cmps.day, cmps.hour, cmps.minute] forState:UIControlStateNormal];
    }
    
    // 发送请求获得更详细的团购数据
    DPAPI *api = [[DPAPI alloc] init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    // 页码
    params[@"deal_id"] = self.deal.deal_id;
    [api requestWithURL:@"v1/deal/get_single_deal" params:params delegate:self];
    
    // 设置收藏状态
//    self.collectButton.selected = [MTDealTool isCollected:self.deal];
}


#pragma mark - DPRequestDelegate
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    self.deal = [TFDeal objectWithKeyValues:[result[@"deals"] firstObject]];
    // 设置退款信息
    self.refundableAnyTimeButton.selected = self.deal.restrictions.is_refundable;
    self.refundableExpireButton.selected = self.deal.restrictions.is_refundable;
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    [MBProgressHUD showError:@"网络繁忙,请稍后再试" toView:self.view];
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
