//
//  TFHomeDropdown.m
//  美团HD
//
//  Created by Tengfei on 16/1/8.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "TFHomeDropdown.h"

@implementation TFHomeDropdown

+(instancetype)dropDown
{
    return [[[NSBundle mainBundle]loadNibNamed:@"TFHomeDropdown" owner:nil options:nil] firstObject];
}







@end
