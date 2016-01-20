//
//  TFDeal.h
//  美团HD
//
//  Created by Tengfei on 16/1/13.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MTRestrictions;
@interface TFDeal : NSObject

/** 团购单ID */
@property (copy, nonatomic) NSString *deal_id;
/** 团购标题 */
@property (copy, nonatomic) NSString *title;
/** 团购描述 */
@property (copy, nonatomic) NSString *desc;
/** 如果想完整地保留服务器返回数字的小数位数(没有小数\1位小数\2位小数等),那么就应该用NSNumber */
/** 团购包含商品原价值 */
@property (strong, nonatomic) NSNumber *list_price;
/** 团购价格 */
@property (strong, nonatomic) NSNumber *current_price;
/** 团购当前已购买数 */
@property (assign, nonatomic) int purchase_count;
/** 团购图片链接，最大图片尺寸450×280 */
@property (copy, nonatomic) NSString *image_url;
/** 小尺寸团购图片链接，最大图片尺寸160×100 */
@property (copy, nonatomic) NSString *s_image_url;
/** string	团购发布上线日期 */
@property (nonatomic, copy) NSString *publish_date;
/** string	团购单的截止购买日期 */
@property (nonatomic, copy) NSString *purchase_deadline;
/** 详情url */
@property (nonatomic, copy) NSString *deal_h5_url;


/** 团购限制条件 */
@property (nonatomic, strong) MTRestrictions *restrictions;


//增加属性
/**
 *  是否正在编辑
 */
@property (nonatomic,assign,getter=isEditing)BOOL editing;

/**
 *  是否打钩
 */
@property (nonatomic,assign,getter=isChecking)BOOL checking;

/**
 {
 "status": "OK",
 "total_count": 11,
 "count": 1,
 "deals": [
 {
 "deal_id": "1-5160525",
 "title": "永华电影城单人电影票套餐",
 "description": "上影永华●海上国际影城连锁影院 仅售36元 价值130元单人电影票套餐 现代化星级影城 高端观影设备 感受震撼视觉享受",
 "city": "上海",
 "list_price": 130,
 "current_price": 36,
 "regions": [
 "徐汇区",
 "浦东新区",
 "黄浦区",
 "普陀区",
 "闵行区",
 "奉贤区"
 ],
 "categories": [
 "电影"
 ],
 "purchase_count": 5080,
 "purchase_deadline": "2014-02-28",
 "publish_date": "2013-12-04",
 "distance": 0,
 "image_url": "http://t3.dpfile.com/pc/mc/37a875004de0eb581709c4c9ffb20d06(450x1024)/thumb.jpg",
 "s_image_url": "http://t1.dpfile.com/pc/mc/37a875004de0eb581709c4c9ffb20d06(450x1024)/thumb_1.jpg",
 "deal_url": "http://dpurl.cn/p/WH0EczH4Yc",
 "deal_h5_url": "http://dpurl.cn/p/iq0zc2H5aS",
 "commission_ratio": 0.03,
 "businesses": [
 {
 "name": "超极电影世界",
 "id": 1795150,
 "city": "上海",
 "latitude": 31.19375,
 "longitude": 121.43953,
 "url": "http://dpurl.cn/p/m2jj4EZEcY",
 "h5_url": "http://dpurl.cn/p/OAfT1SwG+v"
 },
 {
 "name": "新衡山电影院",
 "id": 1796983,
 "city": "上海",
 "latitude": 31.197136,
 "longitude": 121.440895,
 "url": "http://dpurl.cn/p/-UROzi25Mg",
 "h5_url": "http://dpurl.cn/p/KCCs587OZ1"
 },
 {
 "name": "永华电影城",
 "id": 1881676,
 "city": "上海",
 "latitude": 31.194883,
 "longitude": 121.43773,
 "url": "http://dpurl.cn/p/4Xjo0r-xUM",
 "h5_url": "http://dpurl.cn/p/1AhW-fRemq"
 },
 {
 "name": "上影华威电影城",
 "id": 1881682,
 "city": "上海",
 "latitude": 31.235233,
 "longitude": 121.473785,
 "url": "http://dpurl.cn/p/dxswF4kgTz",
 "h5_url": "http://dpurl.cn/p/0UawX9SWzK"
 },
 {
 "name": "海上国际影城(南桥百联店)",
 "id": 4287352,
 "city": "上海",
 "latitude": 30.91587,
 "longitude": 121.48397,
 "url": "http://dpurl.cn/p/YzmYQ3Zh6p",
 "h5_url": "http://dpurl.cn/p/qlqgLVZQVF"
 },
 {
 "name": "海上国际影城(莘庄龙之梦店)",
 "id": 5164689,
 "city": "上海",
 "latitude": 31.108149,
 "longitude": 121.3777,
 "url": "http://dpurl.cn/p/pJ36mK4wp9",
 "h5_url": "http://dpurl.cn/p/PL8ct-zvn5"
 },
 {
 "name": "海上国际影城(喜玛拉雅店)",
 "id": 5479777,
 "city": "上海",
 "latitude": 31.21016,
 "longitude": 121.56175,
 "url": "http://dpurl.cn/p/6ubvOmQNpW",
 "h5_url": "http://dpurl.cn/p/XRbQbO+Jzy"
 },
 {
 "name": "海上国际影城(月星环球港店)",
 "id": 10017328,
 "city": "上海",
 "latitude": 31.23138,
 "longitude": 121.41108,
 "url": "http://dpurl.cn/p/xd7HJmfsVI",
 "h5_url": "http://dpurl.cn/p/NVdbB0CPVJ"
 }
 ]
 }
 ]
 }
 */

@end
