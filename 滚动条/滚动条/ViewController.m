//
//  ViewController.m
//  滚动条
//
//  Created by Tengfei on 2017/5/14.
//  Copyright © 2017年 tengfei. All rights reserved.
//

#import "ViewController.h"
#import "NewsViewController.h"

#define KRandomColor     [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];

@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIButton *selectButton;

@property (nonatomic,weak)UIScrollView * titleScrollView;
@property (nonatomic,weak)UIScrollView * contentScrollView;
@property (nonatomic,strong)NSMutableArray *btns;
@end

@implementation ViewController

-(NSMutableArray *)btns{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"新闻";
    [self setuptitleScorllView];
    [self setupcontentScorllView];
    
    //tian'jia
    [self setALLChildVC];
    
    [self setAlltitle];
    
    //ios7以后，导航控制器中srollview顶部会额外添加64的滚动区域
    //多个Scrollview以后系统会随机让一个Scrollview添加64的额外区域
    self.automaticallyAdjustsScrollViewInsets = NO;

    //选中标题 居中
    
}

-(void)setALLChildVC{
    //
    NSArray *arr = @[@"热播",@"视频",@"社会",@"订阅",@"科技",@"上海",];
    for (int i = 0; i<arr.count; i++) {
        NewsViewController *vc = [[NewsViewController alloc]init];
        vc.title = arr[i];
        vc.view.backgroundColor = KRandomColor;
        [self addChildViewController:vc];
    }
}

-(void)setAlltitle{
    NSInteger count = self.childViewControllers.count;
    
    CGFloat btnW = 100;
    CGFloat btnH = self.titleScrollView.bounds.size.height;
    CGFloat btnX = 0;
    for (int i = 0; i<count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIViewController *vc = self.childViewControllers[i];
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [self.titleScrollView addSubview:btn];
        btnX = i*btnW;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(btnX, 0, btnW, btnH);
        btn.tag = i;
        [self.btns addObject:btn];
        if (i == 0) {
            [self selButton:btn];
        }
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.titleScrollView.contentSize = CGSizeMake(btnX+btnW, 0);
    self.contentScrollView.contentSize = CGSizeMake(count * CGRectGetWidth(self.view.frame), 0);

}

-(void)titleClick:(UIButton *)btn{
    [self selButton:btn];
    
//    UIViewController *vc = self.childViewControllers[btn.tag];
//    CGFloat x = btn.tag * self.view.frame.size.width;
//    vc.view.frame = CGRectMake(x, 0, self.view.frame.size.width, self.contentScrollView.frame.size.height);
//    self.contentScrollView.contentOffset = CGPointMake(x, 0);
//    [self.contentScrollView addSubview:vc.view];
    [self setUoOneVc:btn.tag];
    
    CGFloat x = btn.tag * self.view.frame.size.width;
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
}

- (void)setuptitleScorllView{
    UIScrollView *titleScrollView = [[UIScrollView alloc]init];
    [self.view addSubview:titleScrollView];
    CGFloat y = self.navigationController.navigationBarHidden ? 0 : 64;
    titleScrollView.frame = CGRectMake(0, y, self.view.frame.size.width, 44);
    _titleScrollView = titleScrollView;
    titleScrollView.showsHorizontalScrollIndicator = NO;
    titleScrollView.backgroundColor = [UIColor cyanColor];
}

- (void)setupcontentScorllView{
    UIScrollView *contentScrollView = [[UIScrollView alloc]init];
    [self.view addSubview:contentScrollView];
    CGFloat y = CGRectGetMaxY(self.titleScrollView.frame);
    contentScrollView.frame = CGRectMake(0, y, self.view.frame.size.width, self.view.bounds.size.height - y);
    _contentScrollView = contentScrollView;
    contentScrollView.showsHorizontalScrollIndicator = NO;
    contentScrollView.backgroundColor = [UIColor brownColor];
    contentScrollView.pagingEnabled = YES;
    contentScrollView.bounces = YES;
    contentScrollView.delegate = self;
}
#pragma mark - 选中标题
- (void)selButton:(UIButton *)button
{
    _selectButton.transform = CGAffineTransformIdentity;
    
    [_selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _selectButton = button;
    
    //标题居中
    [self titleLabeCenter:button];
    
    //字体缩放
//    [self setupTitleScale];
    button.transform = CGAffineTransformMakeScale(1.2, 1.2);
}

-(void)setupTitleScale{

}

-(void)titleLabeCenter:(UIButton *)btn{
    //本质修改scrollview的偏移量
    
    CGFloat offsetX = btn.center.x - self.view.frame.size.width *0.5;
    if (offsetX < 0){
        offsetX = 0;
    }
    CGFloat maxoffsetX = self.titleScrollView.contentSize.width - self.view.frame.size.width;
    
    if (offsetX > maxoffsetX) {
        offsetX = maxoffsetX;
    }
    [self.titleScrollView setContentOffset: CGPointMake(offsetX, 0) animated:YES];
}

-(void)setUoOneVc:(NSInteger)i{
 
    UIViewController *vc = self.childViewControllers[i];
    if (vc.view.superview) {//view.viewiflood
        return;
    }
    CGFloat x = i * self.view.frame.size.width;
    vc.view.frame = CGRectMake(x, 0, self.view.frame.size.width, self.contentScrollView.frame.size.height);
    [self.contentScrollView addSubview:vc.view];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //1:选中标题
    NSInteger i = self.contentScrollView.contentOffset.x / self.view.frame.size.width;
    UIButton *btn = self.btns[i];
    [self selButton:btn];
    //2:把对应的字控制器的view添加上去
    //3:
    [self setUoOneVc:i];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //字体缩放渐变】
    NSInteger leftI = scrollView.contentOffset.x / self.view.frame.size.width;
//    UIButton *leftBtn = self.btns
    
    NSInteger rightI = leftI + 1;
    
    UIButton *leftBtn = self.btns[leftI];
    UIButton *rightBt;
    if (rightI < self.btns.count) {
        rightBt = self.btns[rightI];
    }
    
    //缩放
    CGFloat scaleR = scrollView.contentOffset.x / self.view.frame.size.width - leftI;
    CGFloat scaleL = 1 - scaleR;
    
    leftBtn.transform =  CGAffineTransformMakeScale(0.2*scaleL + 1, 0.2*scaleL + 1);
    rightBt.transform =  CGAffineTransformMakeScale(0.2*scaleR + 1, 0.2*scaleR + 1);

    //黑色 000 红色100
    UIColor *righcolor = [UIColor colorWithRed:scaleR green:0.0 blue:0.0 alpha:1.0];
    UIColor *leftcolor = [UIColor colorWithRed:scaleL green:0.0 blue:0.0 alpha:1.0];

    [rightBt setTitleColor:righcolor forState:UIControlStateNormal];
    [leftBtn setTitleColor:leftcolor forState:UIControlStateNormal];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
