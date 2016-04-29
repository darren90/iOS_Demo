//
//  TFMarqueeCell.m
//  MarqueeUPDown
//
//  Created by Fengtf on 16/4/28.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import "TFMarqueeCell.h"
#import "TFMarqueeModel.h"

@interface TFMarqueeCell()

@property (nonatomic,weak)UIImageView * iconView;
@property (nonatomic,weak)UILabel * titleLabe;

@end

@implementation TFMarqueeCell


-(instancetype)init
{
    if (self = [super init]) {
        [self setUpSubViews];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpSubViews];
    }
    return self;
}

-(void)setUpSubViews
{
    UIImageView *iconView = [[UIImageView alloc]init];
    self.iconView = iconView;
    [self addSubview:iconView];
    iconView.contentMode = UIViewContentModeCenter;
    iconView.clipsToBounds = YES;
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabe = titleLabel;
    [self addSubview:titleLabel];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    self.iconView.frame = CGRectMake(0, 0, 30, h);
    self.titleLabe.frame = CGRectMake(CGRectGetMaxX(self.iconView.frame)+8, 0, w - CGRectGetWidth(self.iconView.frame)-8-10, h);
}

-(void)setModel:(TFMarqueeModel *)model
{
    _model = model;
    
//    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:self.placeholderImage]];
    self.iconView.image = [UIImage imageNamed:@"ic_speaker"];//model.imgUrl;
    self.titleLabe.text = model.tittle;
}
@end
