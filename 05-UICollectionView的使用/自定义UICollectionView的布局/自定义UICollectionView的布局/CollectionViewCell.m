//
//  CollectionViewCell.m
//  自定义UICollectionView的布局
//
//  Created by Tengfei on 16/1/4.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "CollectionViewCell.h"
#define KRandomColor     [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];

@interface CollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation CollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = KRandomColor;
}

-(void)setIndex:(NSInteger)index
{
    _index = index;
    
    self.label.text = [NSString stringWithFormat:@"%ld",(long)index];
}

@end
