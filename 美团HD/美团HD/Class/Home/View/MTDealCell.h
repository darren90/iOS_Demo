//
//  MTDealCell.h
//  黑团HD
//
//  Created by apple on 14-8-19.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTDeal, TFDeal;


@interface MTDealCell : UICollectionViewCell
@property (nonatomic, strong) TFDeal *deal;

/**
 *  是否正在编辑
 */
//@property (nonatomic,assign,getter=isEditing)BOOL editing;
@end
