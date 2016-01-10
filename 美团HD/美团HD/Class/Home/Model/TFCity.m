//
//  TFCity.m
//  美团HD
//
//  Created by Tengfei on 16/1/10.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "TFCity.h"
#import "MJExtension.h"
#import "TFregion.h"

@implementation TFCity

-(NSDictionary *)objectClassInArray{
    return @{@"regions" : [TFregion class]};
}

@end
