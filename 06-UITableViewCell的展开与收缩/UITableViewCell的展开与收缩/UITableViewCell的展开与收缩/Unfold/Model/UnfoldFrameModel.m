
//
//  UnfoldFrameModel.m
//  UITableViewCell的展开与收缩
//
//  Created by Fengtf on 15/12/28.
//  Copyright © 2015年 ftf. All rights reserved.
//

#import "UnfoldFrameModel.h"
#import "UnfoldModel.h"

@implementation UnfoldFrameModel


-(void)setModel:(UnfoldModel *)model
{
    _model = model;

    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    CGFloat margin = 8;
    self.contentF = CGRectMake(margin, margin, cellW - 2 * margin, 200);
    
    CGFloat btnW = 50;
    self.unflodBtnF = CGRectMake(cellW - btnW - margin, CGRectGetMaxY(self.contentF), btnW, 30);
    
    self.cellH = CGRectGetMaxY(self.unflodBtnF)+margin;
}

@end
