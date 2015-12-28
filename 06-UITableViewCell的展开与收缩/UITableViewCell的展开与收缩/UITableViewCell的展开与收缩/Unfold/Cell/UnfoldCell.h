//
//  UnfoldCell.h
//  UITableViewCell的展开与收缩
//
//  Created by Fengtf on 15/12/28.
//  Copyright © 2015年 ftf. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UnfoldCellDelegate  <NSObject>
@optional
-(void)UnfoldCellDidClickUnfoldBtn;
@end

@class UnfoldFrameModel;
@interface UnfoldCell : UITableViewCell


@property (nonatomic,strong)UnfoldFrameModel * frameModel;


@property (nonatomic,weak)id<UnfoldCellDelegate> delegate;

@end
