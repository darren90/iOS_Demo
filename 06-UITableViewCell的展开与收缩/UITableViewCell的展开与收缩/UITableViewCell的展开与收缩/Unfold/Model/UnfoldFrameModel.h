//
//  UnfoldFrameModel.h
//  UITableViewCell的展开与收缩
//
//  Created by Fengtf on 15/12/28.
//  Copyright © 2015年 ftf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class UnfoldModel;
@interface UnfoldFrameModel : NSObject

@property (nonatomic,strong)UnfoldModel *model;


@property (nonatomic,assign)CGRect contentF;

@property (nonatomic,assign)CGRect unflodBtnF;


@property (nonatomic,assign)CGFloat cellH;

@end
