//
//  TFMarqueeCell.h
//  MarqueeUPDown
//
//  Created by Fengtf on 16/4/28.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TFMarqueeModel;
@interface TFMarqueeCell : UICollectionViewCell

@property (nonatomic,strong)TFMarqueeModel * model;
@property (nonatomic,copy)NSString * placeholderImage;

@end
