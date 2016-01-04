//
//  CollectionViewCell.m
//  自定义UICollectionView的布局
//
//  Created by Tengfei on 16/1/4.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *label;


@end

@implementation CollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setIndex:(NSInteger)index
{
    _index = index;
    
    self.label.text = [NSString stringWithFormat:@"%ld",(long)index];
}

@end
