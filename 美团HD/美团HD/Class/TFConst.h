
#import <Foundation/Foundation.h>




#ifdef DEBUG
#define MTLog(...) NSLog(__VA_ARGS__)
#else
#define MTLog(...)
#endif

#define MTColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define MTGlobalBg MTColor(230, 230, 230)

#define  TFNotificationCenter [NSNotificationCenter defaultCenter]

extern NSString *const TFCityDidSelectNotification;

extern NSString *const TFSelectCityName;

