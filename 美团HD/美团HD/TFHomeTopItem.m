//
//  TFHomeTopItem.m
//  美团HD
//
//  Created by Tengfei on 16/1/7.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "TFHomeTopItem.h"

@implementation TFHomeTopItem

+(instancetype)item
{
    return [[[NSBundle mainBundle]loadNibNamed:@"TFHomeTopItem" owner:nil options:nil] firstObject];
}

@end
