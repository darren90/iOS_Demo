//
//  UnfoldCell.m
//  UITableViewCell的展开与收缩
//
//  Created by Fengtf on 15/12/28.
//  Copyright © 2015年 ftf. All rights reserved.
//

#import "UnfoldCell.h"
#import "UnfoldFrameModel.h"
#import "UnfoldModel.h"

@interface UnfoldCell ()

@property (nonatomic,weak)UILabel * contentLabel;


@property (nonatomic,weak)UIButton * unfoldBtn;

@end

@implementation UnfoldCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *contentLabel = [[UILabel alloc]init];
        [self.contentView addSubview:contentLabel];
        self.contentLabel = contentLabel;
        contentLabel.numberOfLines = 0;
        contentLabel.font = [UIFont systemFontOfSize:16];
        contentLabel.userInteractionEnabled = YES;
        
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(unflodCell)];
        [contentLabel addGestureRecognizer:tap];
        
        UIButton *unfoldBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.unfoldBtn = unfoldBtn;
        [self.contentView addSubview:unfoldBtn];
        [self.unfoldBtn setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
//        [self.unfoldBtn setTitle:@"显示全部" forState:UIControlStateNormal];
        [unfoldBtn addTarget:self action:@selector(unflodCell) forControlEvents:UIControlEventTouchUpInside];
        
//        contentLabel.backgroundColor = [UIColor grayColor];
//        unfoldBtn.backgroundColor = [UIColor blueColor];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];

}

-(void)unflodCell
{
//    UnfoldModel *model = self.frameModel.model;
//    model.isUnflod = !model.isUnflod;
    
    if ([self.delegate respondsToSelector:@selector(UnfoldCellDidClickUnfoldBtn:)]) {
        [self.delegate UnfoldCellDidClickUnfoldBtn:self.frameModel];
    }
}


-(void)setFrameModel:(UnfoldFrameModel *)frameModel
{
    _frameModel = frameModel;
    
    UnfoldModel *model = frameModel.model;
    
    self.contentLabel.frame = frameModel.contentF;
    self.unfoldBtn.frame = frameModel.unflodBtnF;
    
    self.contentLabel.text = model.contenxt;
    
    if (model.isUnflod) {
        [self.unfoldBtn setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
//        [self.unfoldBtn setTitle:@"显示全部" forState:UIControlStateNormal];
    }else{
        [self.unfoldBtn setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
//        [self.unfoldBtn setTitle:@"收起" forState:UIControlStateNormal];
    }
}
 
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
