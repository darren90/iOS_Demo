//
//  DLFixedTabbarView.h
//  DLSlideController
//
//  Created by Dongle Su on 14-12-8.
//  Copyright (c) 2014年 dongle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLSlideTabbarProtocol.h"

@interface DLFixedTabbarViewTabItem : NSObject
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) UIColor *titleColor;
@property(nonatomic, strong) UIColor *selectedTitleColor;

/**
 *  字体大小
 */
@property (nonatomic,strong)UIFont * titleFont;

@end

@interface DLFixedTabbarView : UIView<DLSlideTabbarProtocol>
@property(nonatomic, strong) UIImage *backgroundImage;
@property(nonatomic, strong) UIColor *trackColor;
@property(nonatomic, strong) NSArray *tabbarItems;

@property(nonatomic, assign) NSInteger selectedIndex;
@property(nonatomic, readonly) NSInteger tabbarCount;
@property(nonatomic, weak) id<DLSlideTabbarDelegate> delegate;
- (void)switchingFrom:(NSInteger)fromIndex to:(NSInteger)toIndex percent:(float)percent;

@end
