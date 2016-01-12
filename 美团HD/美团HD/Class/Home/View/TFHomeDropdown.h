//
//  TFHomeDropdown.h
//  美团HD
//
//  Created by Tengfei on 16/1/8.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TFHomeDropdown;

//@protocol TFHomeDropdownData <NSObject>
//
//-(NSString *)title;
//-(NSString *)icon;
//-(NSString *)selectedIcon;
//-(NSArray *)subData;
//
//@end


@protocol TFHomeDropdownDataSource <NSObject>

/**
 *  告诉下拉菜单，左边的表格一共多少行
 *
 *  @param homeDropdown
 */
-(NSInteger)numofRowsInMainTable:(TFHomeDropdown *)homeDropdown ;
/**
 *  左边表格每一行的具体数据
 *
 *  @param homeDropdown model
 *  @param row          行号
 *
 *  @return 遵守协议
 */
//-(id<TFHomeDropdownData>)homeDropdown:(TFHomeDropdown *)homeDropdown titleForInMainTable:(int)row;

/**
 *  告诉下拉菜单，左边的表格一共多少行
 *
 *  @param homeDropdown
 */
-(NSInteger)numofRowsInMainTable:(TFHomeDropdown *)homeDropdown ;

/**
 *  左边每一行的文字
 *
 *  @param homeDropdown model
 *  @param row          行号
 *
 *  @return
 */
-(NSString *)homeDropdown:(TFHomeDropdown *)homeDropdown titleForInMainTable:(int)row;

/**
 *  每一行的左边的子数据
 *
 *  @param homeDropdown model
 *  @param row          行号
 *
 *  @return
 */
-(NSArray *)homeDropdown:(TFHomeDropdown *)homeDropdown subDataForInMainTable:(int)row;
@optional
/**
 *  左边每一行的图标
 *
 *  @param homeDropdown model
 *  @param row          行号
 *
 *  @return
 */
-(NSString *)homeDropdown:(TFHomeDropdown *)homeDropdown iconForInMainTable:(int)row;
/**
 *  左边每一行的选中的图片
 *
 *  @param homeDropdown model
 *  @param row          行号
 *
 *  @return
 */
-(NSString *)homeDropdown:(TFHomeDropdown *)homeDropdown selectIconForInMainTable:(int)row;
//-(NSArray *)subDataForRowInMainTable:(int)row;

@end


@interface TFHomeDropdown : UIView
+(instancetype)dropDown;


@property (nonatomic,strong)NSArray * categories;


@property (nonatomic,weak)id<TFHomeDropdownDataSource> dataSource;


///**
// *  data数组中必须遵守TFHomeDropdownData协议
// */
//@property (nonatomic,strong)NSArray * data;


@end









