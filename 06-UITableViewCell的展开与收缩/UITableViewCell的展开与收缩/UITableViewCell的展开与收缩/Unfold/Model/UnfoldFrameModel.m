
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
    CGFloat contentLabelW =  cellW - 2 * margin;
    CGFloat contentH = [model.contenxt boundingRectWithSize:CGSizeMake(contentLabelW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:16]} context:nil].size.height;
    CGFloat oneLineH = [@"这是一行" boundingRectWithSize:CGSizeMake(contentLabelW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:16]} context:nil].size.height;

    if (!model.isUnflod) {
        if (contentH > 3 * oneLineH) {
            contentH = 3*oneLineH;
        }
    } 
    
    self.contentF = CGRectMake(margin, margin,contentLabelW,contentH);
    
    CGFloat btnW = 50;
    self.unflodBtnF = CGRectMake(cellW - btnW - margin, CGRectGetMaxY(self.contentF), btnW, 30);
    
    self.cellH = CGRectGetMaxY(self.unflodBtnF)+margin;
}
 

@end
