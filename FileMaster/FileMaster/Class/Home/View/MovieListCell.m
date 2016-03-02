//
//  MovieListCell.m
//  FileMaster
//
//  Created by Tengfei on 16/2/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "MovieListCell.h"
#import "MovieList.h"

@interface MovieListCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation MovieListCell

- (void)awakeFromNib {
    // Initialization code
    self.iconView.clipsToBounds = YES;
}

-(void)setModel:(MovieList *)model
{
    self.iconView.image = model.imgData;
    self.nameLabel.text = model.name;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
