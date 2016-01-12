//
//  TFSortViewController.m
//  美团HD
//
//  Created by Tengfei on 16/1/12.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "TFSortViewController.h"
#import "TFMetaTool.h"
#import "TFSort.h"
#import "UIView+Extension.h"
#import "TFConst.h"

/** ---TFButton---- */
@class TFSort;
@interface TFButton : UIButton
@property (nonatomic,strong)TFSort * model;
@end


@implementation TFButton


@end

/** ---TFSortViewController---- */

@interface TFSortViewController ()

@end

@implementation TFSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *sorts = [TFMetaTool sorts];
    NSUInteger count = sorts.count;
    
    CGFloat btnW = 100;
    CGFloat btnH = 30;
    CGFloat btnX = 15;
    CGFloat btnStartY = 15;
    CGFloat btnMargin = 15;
    
    CGFloat height = 0;
    for (NSUInteger i = 0; i < count; i++) {
        TFSort *sort = sorts[i];
        
        TFButton *btn = [TFButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:sort.label forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_filter_normal"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_filter_selected"] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        btn.model = sort;
        
        btn.width = btnW;
        btn.height = btnH;
        btn.x = btnX;
        btn.y = btnStartY + (btnH+btnMargin)*i;
        [btn addTarget:self action:@selector(btnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        height = CGRectGetMaxY(btn.frame);
    }
    
    //设置控制器中的尺寸
    CGFloat width = btnW + 2*btnX;
    height += btnMargin;
    self.preferredContentSize = CGSizeMake(width, height);
}


-(void)btnDidClick:(TFButton *)btn
{
//    TFCityGroup *citys = self.cities[indexPath.section];
    [TFNotificationCenter postNotificationName:TFSortDidSelectNotification object:nil userInfo:@{TFSelectSortName :btn.model}];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
