//
//  UnfoldCell.m
//  UITableViewCell的展开与收缩
//
//  Created by Fengtf on 15/12/28.
//  Copyright © 2015年 ftf. All rights reserved.
//

#import "UnfoldCell.h"
#import "UnfoldFrameModel.h"

@interface UnfoldCell ()



@end

@implementation UnfoldCell



- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
