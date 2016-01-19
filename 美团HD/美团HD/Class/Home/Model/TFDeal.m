//
//  TFDeal.m
//  美团HD
//
//  Created by Tengfei on 16/1/13.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "TFDeal.h"
#import "MJExtension.h"

@implementation TFDeal
MJCodingImplementation
- (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"desc" : @"description"};
}


- (BOOL)isEqual:(TFDeal *)other
{
    return [self.deal_id isEqual:other.deal_id];
}
@end
