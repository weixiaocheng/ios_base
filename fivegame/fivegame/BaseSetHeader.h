//
//  BaseSetHeader.h
//  IOSBASE
//
//  Created by apple on 2019/4/2.
//  Copyright © 2019 corzen. All rights reserved.
//

#ifndef BaseSetHeader_h
#define BaseSetHeader_h
// 边距
#define BaseMarginSize (KCAdaptedWidth(30))
#define BaseTextfieldHeight (KCAdaptedHeight(50))

// 字体信息
#define TitleFont 16
#define DefaultBtnFont (KCAdaptedHeight(22))
#define SureBtnFont (KCAdaptedHeight(32))

// 颜色值
#define KCButtonNormalColor SwitchColor(@"#8831a7") // 主题色
#define KCButtonDisabledColor SwitchColor(@"#cccccc")

// 宽高信息
#define SCREEN_HEIGHTL [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTHL [UIScreen mainScreen].bounds.size.width

// 弱关系
#define WeakSelf __weak typeof(self) weakSelf = self;

//判断iPHoneX、iPHoneXs
#define SCREENSIZE_IS_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !UI_IS_IPAD : NO)
#define SCREENSIZE_IS_XS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !UI_IS_IPAD : NO)

//判断iPhoneXs Max
#define SCREENSIZE_IS_XS_MAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !UI_IS_IPAD : NO)

#define IS_IPhoneX_All ([UIScreen mainScreen].bounds.size.height == 812 || [UIScreen mainScreen].bounds.size.height == 896)

//状态栏、导航栏、标签栏高度
#define Height_StatusBar [[UIApplication sharedApplication] statusBarFrame].size.height

#define Height_NavBar 44.0f

#define Height_TopBar (Height_StatusBar + Height_NavBar)

#define Height_TapBar (IS_IPhoneX_All ? 83.0f:49.0f)

#define Height_BottomSafe (IS_IPhoneX_All? 34.0f:0.0f)

#define RGB16(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define RGBAlpha(rgbValue,alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

#define RandColor RGBColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#define RGBAColor(r, g, b ,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define SwitchColor(x) [CommonMethod colorWithHexColorString:x]

//不同屏幕尺寸字体适配
#define kScreenWidthRatio  (UIScreen.mainScreen.bounds.size.width / (375.0*2))
#define kScreenHeightRatio (UIScreen.mainScreen.bounds.size.height / (667.0*2))
//#define KCAdaptedWidth(x)  ceilf((x) * kScreenWidthRatio)
//#define KCAdaptedHeight(x) ceilf((x) * kScreenHeightRatio)
#define KCAdaptedWidth(x)  ((x) * kScreenWidthRatio)
#define KCAdaptedHeight(x) ((x) * kScreenHeightRatio)
#define AdaptedFontSize(R)     [UIFont systemFontOfSize:AdaptedWidth(R)]

// 密码最大长度
#define PSSWORDMAXLENGTH 32

#ifdef DEBUG
#define NSLog(fmt, ...) NSLog((@"%s\n" "%s\n" "%d \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define NSLog(...);
#endif
#endif /* BaseSetHeader_h */
