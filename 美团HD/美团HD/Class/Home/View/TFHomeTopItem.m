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

@end

@implementation TFHomeTopItem

+(instancetype)item
{
    return [[[NSBundle mainBundle]loadNibNamed:@"TFHomeTopItem" owner:nil options:nil] firstObject];
}

- (IBAction)didClick:(UIButton *)sender {
}



-(void)addTaget:(id)target action:(SEL)action
{
    [self.button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}
@end
