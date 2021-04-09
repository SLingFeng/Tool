//
//  UIColor+LF.m
//  Tool
//
//  Created by mac on 2021/4/9.
//

#import "UIColor+LF.h"

@implementation UIColor (LF)

#pragma mark - 颜色
+(UIColor *)getTitleColor {
    UIColor * color = [UIColor blackColor];
    return color;
}

+(UIColor *)getSecondaryTitleColor {
    UIColor * color = RGBCOLOR(70, 70, 70);
    return color;
}

+(UIColor *)getNavBarColor {
    return kMainColor;
}

+(UIColor *)getNavTintTextColor {
    UIColor * color = [UIColor blackColor];
    return color;
}

+(UIColor *)getTextLightColor {
    UIColor * color = [UIColor lightGrayColor];
    return color;
}

+(UIColor *)getTextHColor {
    UIColor * color = RGBCOLOR(245, 117, 10);
    return color;
}

+(UIColor *)getBackgroundColor {
    UIColor * color = [UIColor whiteColor];//[UIColor colorHex:@"f2f2f2"];
    return color;
}
+(UIColor *)getBackgroundDarkColor {
    UIColor * color = RGBCOLOR(175, 182, 187);
    return color;
}

+(UIColor *)getBackgroundLightColor {
    UIColor * color = [UIColor colorHex:@"f2f2f2"];
    return color;
}

+(UIColor *)getMainColor {
    return [UIColor colorHex:@"ff0000"];
}

+(UIColor *)text33Color {
//kCOLOR_WITH_RBG(51, 51, 51);
    return [UIColor colorHex:@"333333"];
}

+(UIColor *)text66Color {
//kCOLOR_WITH_RBG(102, 102, 102);
    return [UIColor colorHex:@"666666"];
}

+(UIColor *)text99Color {
//kCOLOR_WITH_RBG(153, 153, 153);
    return [UIColor colorHex:@"999999"];
}
///颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *)colorHex:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}
+ (UIColor *)colorHex:(NSInteger)color alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((color & 0xFF0000) >> 16))/255.0 green:((float)((color & 0xFF00) >> 8))/255.0 blue:((float)(color & 0xFF))/255.0 alpha:alpha];
//    return HEXCOLORA(<#rgbValue#>, a)
//    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
//
//    // String should be 6 or 8 characters
//    if ([cString length] < 6) {
//        return [UIColor clearColor];
//    }
//
//    // strip 0X if it appears
//    if ([cString hasPrefix:@"0X"])
//        cString = [cString substringFromIndex:2];
//    if ([cString hasPrefix:@"#"])
//        cString = [cString substringFromIndex:1];
//    if ([cString length] != 6)
//        return [UIColor clearColor];
//    // Separate into r, g, b substrings
//    NSRange range;
//    range.location = 0;
//    range.length = 2;
//    //r
//    NSString *rString = [cString substringWithRange:range];
//    //g
//    range.location = 2;
//    NSString *gString = [cString substringWithRange:range];
//    //b
//    range.location = 4;
//    NSString *bString = [cString substringWithRange:range];
//    // Scan values
//    unsigned int r, g, b;
//    [[NSScanner scannerWithString:rString] scanHexInt:&r];
//    [[NSScanner scannerWithString:gString] scanHexInt:&g];
//    [[NSScanner scannerWithString:bString] scanHexInt:&b];
//
//    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

@end
