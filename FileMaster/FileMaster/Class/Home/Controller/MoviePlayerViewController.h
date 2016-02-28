//
//  MoviePlayerViewController.h
//  FileMaster
//
//  Created by Tengfei on 16/2/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,SwipeStyle) {
    PlayerSwipeUnKnown = -1,
    PlayerSwipePlaySpeed =  0,
    PlayerSwipePlayVoice =  1,
    PlayerSwipePlayLight =  2,
};

@class VKVideoPlayer;

@interface MoviePlayerViewController : UIViewController


/** 当前更新到第几集 */
@property (nonatomic,assign)int updateNum;
/** 当前需要播放第几集 */
@property (nonatomic,assign)int currentNum;

/**
 *  上次播放到第几秒；注：单位是秒，播放器会自动向前退5s
 */
@property (nonatomic,strong)NSNumber *lastDurationTime;

/** 传递的PlayerUrl。播放地址 */
@property (nonatomic,strong)NSString * playerUrl;

/** 标题 */
@property (nonatomic,copy)NSString * topTitle;


@property (nonatomic,assign)SwipeStyle swipeType;
