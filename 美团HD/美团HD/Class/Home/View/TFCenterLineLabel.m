//
//  TFCenterLineLabel.m
//  美团HD
//
//  Created by Tengfei on 16/1/13.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "TFCenterLineLabel.h"

@implementation TFCenterLineLabel

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    UIRectFill(CGRectMake(0, rect.size.height * 0.5, rect.size.width, 1));
    
    //    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 画线
    // 设置起点
    //    CGContextMoveToPoint(ctx, 0, rect.size.height * 0.5);
    //    // 连线到另一个点
    //    CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height * 0.5);
    //    // 渲染
    //    CGContextStrokePath(ctx);
}
@end
