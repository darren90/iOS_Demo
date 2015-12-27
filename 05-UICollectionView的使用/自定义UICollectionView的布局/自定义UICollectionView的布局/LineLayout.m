//
//  LineLayout.m
//  自定义UICollectionView的布局
//
//  Created by Tengfei on 15/12/27.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "LineLayout.h"

static const CGFloat ItemHW = 100;

@implementation LineLayout

-(instancetype)init
{
    if (self = [super init]) {
        //初始化
        self.itemSize = CGSizeMake(ItemHW, ItemHW);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

@end
