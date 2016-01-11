//
//  TFHomeTopItem.m
//  美团HD
//
//  Created by Tengfei on 16/1/7.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "TFHomeTopItem.h"

@interface TFHomeTopItem ()

@end

@interface TFHomeTopItem ()

- (IBAction)didClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end

@implementation TFHomeTopItem


-(void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;//不拉伸
}


+(instancetype)item
{
    return [[[NSBundle mainBundle]loadNibNamed:@"TFHomeTopItem" owner:nil options:nil] firstObject];
}


-(void)setIcon:(NSString *)icon highIcon:(NSString *)highIcon
{
    [self.button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [self.button setImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

-(void)setSubTitle:(NSString *)subTitle
{
    _subTitle = subTitle;
    self.subTitleLabel.text = subTitle;
}

- (IBAction)didClick:(UIButton *)sender {
}



-(void)addTaget:(id)target action:(SEL)action
{
    [self.button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}
@end
