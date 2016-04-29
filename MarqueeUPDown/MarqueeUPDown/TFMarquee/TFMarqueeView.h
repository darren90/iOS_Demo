//
//  TFMarqueeView.h
//  MarqueeUPDown
//
//  Created by Fengtf on 16/4/28.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MarqueeViewDelegate <NSObject>

@optional
-(void)marqueeViewDidSelectAtIndex:(NSInteger)index;
@end

@interface TFMarqueeView : UIView


@property (nonatomic,strong)NSArray * imgsArray;

@property (nonatomic,copy)NSString * placeholderImage;
@property (nonatomic,weak)id<MarqueeViewDelegate> delegate;


@end
