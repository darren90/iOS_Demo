//
//  ViewController.m
//  MarqueeUPDown
//
//  Created by Fengtf on 16/4/28.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import "ViewController.h"
#import "TFMarqueeView.h"

@interface ViewController ()<MarqueeViewDelegate>
@property (nonatomic,weak)TFMarqueeView *marqueeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    TFMarqueeView *marqueeView = [[TFMarqueeView alloc]init];
    marqueeView.frame = CGRectMake(0,100, self.view.frame.size.width, 40);
    self.marqueeView = marqueeView;
    marqueeView.backgroundColor = [UIColor brownColor];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:marqueeView];
    marqueeView.delegate = self;
    
    // 情景二：采用网络图片实现
    NSArray *imagesURLStrings = @[
                                  @"神盾大家族好不好看",
                                  @"Skey逆反了，后续剧情如何",
                                  @"乔布斯毕业演讲人人改听的三次",
                                  @"Apple8000普光，大家反映难看",
                                  @"http://p1.so.qhimg.com/t01739d7baafb216b61"
                                  ];
//    marqueeView.placeholderImage = @"nopic_780x420";
    marqueeView.imgsArray = imagesURLStrings;
}

-(void)marqueeViewDidSelectAtIndex:(NSInteger)index
{
    NSLog(@"----当前点击的是第%ld个",(long)index);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
