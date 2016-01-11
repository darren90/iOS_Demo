//
//  TFHomeTopItem.h
//  美团HD
//
//  Created by Tengfei on 16/1/7.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFHomeTopItem : UIView

+(instancetype)item;

/**
 *  设置点击的监听器
 *
 *  @param target 监听器
 *  @param action 监听方法
 */
-(void)addTaget:(id)target action:(SEL)action;



@property (nonatomic,copy)NSString * title;

@property (nonatomic,copy)NSString * subTitle;


-(void)setIcon:(NSString *)icon highIcon:(NSString *)highIcon;

//@property (nonatomic,copy)NSString * icon;
//
//@property (nonatomic,copy)NSString * highIcon;


@end
