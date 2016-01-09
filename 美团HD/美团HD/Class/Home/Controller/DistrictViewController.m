//
//  DistrictViewController.m
//  美团HD
//
//  Created by Tengfei on 16/1/9.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "DistrictViewController.h"
#import "TFHomeDropdown.h"
#import "Masonry.h"

@interface DistrictViewController ()
@property (weak, nonatomic) IBOutlet UIView *titleView;

@end

@implementation DistrictViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    TFHomeDropdown *dropdown = [TFHomeDropdown dropDown];
    [self.view addSubview:dropdown];
//    dropdown.frame = CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height);
    [dropdown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
//    dropdown.backgroundColor = [UIColor grayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
