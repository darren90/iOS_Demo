
#import <Foundation/Foundation.h>




#ifdef DEBUG
#define MTLog(...) NSLog(__VA_ARGS__)
#else
#define MTLog(...)
#endif

#define MTColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define MTGlobalBg MTColor(230, 230, 230)

#define  TFNotificationCenter [NSNotificationCenter defaultCenter]

//弹出选择城市
extern NSString *const TFCityDidSelectNotification;
extern NSString *const TFSelectCityName;

//排序选择
extern NSString *const TFSortDidSelectNotification;
extern NSString *const TFSelectSortName;

//分类选择
extern NSString *const TFCategoryDidSelectNotification;
extern NSString *const TFSelectCategoryName;
extern NSString *const TFSelectSubCategoryName;


//区域选择
extern NSString *const TFReginDidSelectNotification;
extern NSString *const TFSelectReginName;
extern NSString *const TFSelectSubReginName;




extern NSString *const MTCollectStateDidChangeNotification;
extern NSString *const MTIsCollectKey;
extern NSString *const MTCollectDealKey;
