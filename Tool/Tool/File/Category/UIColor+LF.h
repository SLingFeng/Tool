//
//  UIColor+LF.h
//  Tool
//
//  Created by mac on 2021/4/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define k333333 [UIColor colorHex:@"333333"]

#define k555555 [UIColor colorHex:@"555555"]

#define k666666 [UIColor colorHex:@"666666"]

#define k888888 [UIColor colorHex:@"888888"]

#define k999999 [UIColor colorHex:@"999999"]

#define kFFFFFF [UIColor colorHex:@"ffffff"]

#define k111111 [UIColor colorHex:@"111111"]

#define k000000 [UIColor colorHex:@"000000"]

#define kFF0000 [UIColor colorHex:@"ff0000"]

#define kFF7E00 [UIColor colorHex:@"ff7e00"]

#define kF2F2F2 [UIColor colorHex:@"F2F2F2"]

#define kF5F5F5 [UIColor colorHex:@"F5F5F5"]

#define kLineColor [UIColor colorHex:@"F2F2F2"]

#define kA1A1A1 [UIColor colorHex:@"A1A1A1"]

#define kMainColor [UIColor colorHex:@"00AAF7"]

#define kBED500 [UIColor colorHex:@"BED500"]

#define kEEEEEE [UIColor colorHex:@"eeeeee"]

#define kEFEFEF [UIColor colorHex:@"EFEFEF"]

#define kFF4848 [UIColor colorHex:@"FF4848"]

#define KBGCOLOR [UIColor whiteColor]

@interface UIColor (LF)

#pragma mark - 颜色
/**
 *  @author LingFeng, 2016-06-08 11:06:46
 *
 *  标题颜色
 *
 *  @return 颜色
 */
+(UIColor *)getTitleColor;
/**
 *  @author LingFeng, 2016-06-08 11:06:02
 *
 *  次级标题颜色
 *
 *  @return 颜色
 */
+(UIColor *)getSecondaryTitleColor;
/**
 *  @author LingFeng, 2016-06-08 11:06:12
 *
 *  正文顏色
 *
 *  @return 顏色
 */
+(UIColor *)getTextLightColor;
/**
 *  @author LingFeng, 2016-06-13 14:06:19
 *
 *  文本高亮颜色
 *
 *  @return 文本高亮颜色
 */
+(UIColor *)getTextHColor;
/**
 *  @author LingFeng, 2016-06-08 11:06:22
 *
 *  导航颜色
 *
 *  @return 导航颜色
 */
+(UIColor *)getNavBarColor;
/**
 *  @author LingFeng, 2016-06-08 11:06:36
 *
 *  导航字体颜色
 *
 *  @return 导航字体颜色
 */
+(UIColor *)getNavTintTextColor;
/**
 * @author LingFeng, 2016-06-24 09:06:29
 *
 * 正常字体颜色
 *
 * @return 正常字体颜色 51 33
 */
+(UIColor *)text33Color;
/**
 * @author LingFeng, 2016-06-24 09:06:54
 *
 * 字体颜色
 *
 * @return 字体颜色 102 66
 */
+(UIColor *)text66Color;
/**
 * @author LingFeng, 2016-06-24 09:06:07
 *
 * 字体颜色
 *
 * @return 字体颜色 153 99
 */
+(UIColor *)text99Color;
/**
 主题颜色

 @return 主题颜色
 */
+(UIColor *)getMainColor;

/**
 *  @author LingFeng, 2016-06-08 17:06:32
 *
 *  背景颜色
 *
 *  @return 背景颜色
 */
+(UIColor *)getBackgroundColor;

+(UIColor *)getBackgroundDarkColor;

+(UIColor *)getBackgroundLightColor;

//颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *)colorHex:(NSString *)color;
+ (UIColor *)colorHex:(NSInteger)color alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
