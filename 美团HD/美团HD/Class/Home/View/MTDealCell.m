//
//  MTDealCell.m
//  黑团HD
//
//  Created by apple on 14-8-19.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "MTDealCell.h"
#import "TFDeal.h"
#import "UIImageView+WebCache.h"

@interface MTDealCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *listPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *purchaseCountLabel;
/**
 属性名不能以new开头
 */
@property (weak, nonatomic) IBOutlet UIImageView *dealNewView;
@property (weak, nonatomic) IBOutlet UIButton *cover;
@property (weak, nonatomic) IBOutlet UIImageView *selectImg;

- (IBAction)coverClick:(UIButton *)sender;

@end

@implementation MTDealCell

- (void)awakeFromNib
{
    // 拉伸
//    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dealcell"]];
    // 平铺
//    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_dealcell"]];
}

- (void)setDeal:(TFDeal *)deal
{
    _deal = deal;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:deal.s_image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"]];
    self.titleLabel.text = deal.title;
    self.descLabel.text = deal.desc;
    
    // 购买数
    self.purchaseCountLabel.text = [NSString stringWithFormat:@"已售%d", deal.purchase_count];
    
    // 现价
    self.currentPriceLabel.text = [NSString stringWithFormat:@"¥ %@", deal.current_price];
    NSUInteger dotLoc = [self.currentPriceLabel.text rangeOfString:@"."].location;
    if (dotLoc != NSNotFound) {
        // 超过2位小数
        if (self.currentPriceLabel.text.length - dotLoc > 3) {
            self.currentPriceLabel.text = [self.currentPriceLabel.text substringToIndex:dotLoc + 3];
        }
    }
    
    // 原价
    self.listPriceLabel.text = [NSString stringWithFormat:@"¥ %@", deal.list_price];
    
    // 是否显示新单图片
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat= @"yyyy-MM-dd";
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    // 隐藏: 发布日期 < 今天
    self.dealNewView.hidden = ([deal.publish_date compare:nowStr] == NSOrderedAscending);
}


-(void)setEditing:(BOOL)editing
{
    _editing = editing;
    
    self.cover.hidden = !self.cover.hidden;
//    self.selectImg.hidden = NO;
}

- (void)drawRect:(CGRect)rect
{
    // 平铺
//    [[UIImage imageNamed:@"bg_dealcell"] drawAsPatternInRect:rect];
    // 拉伸
    [[UIImage imageNamed:@"bg_dealcell"] drawInRect:rect];
}
- (IBAction)coverClick:(UIButton *)sender {
}
@end
