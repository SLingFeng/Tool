//
//  UIColor+LF.m
//  Tool
//
//  Created by mac on 2021/4/9.
//

#import "UIColor+LF.h"
#import "NSString+LF.h"

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
+ (UIColor *)colorHex:(NSString *)color {
    return [UIColor colorHex:color alpha:1.0];
}

+ (UIColor *)colorHex:(NSString *)string alpha:(CGFloat)alpha {
    if ( nil == string || 0 == string.length )
        return nil;
    
    string = string.trim;
    
    if ( [string hasPrefix:@"rgb("] && [string hasSuffix:@")"] )
    {
        string = [string substringWithRange:NSMakeRange(4, string.length - 5)];
        if ( string && string.length )
        {
            NSArray * elems = [string componentsSeparatedByString:@","];
            if ( elems && elems.count == 3 )
            {
                NSInteger r = [[elems objectAtIndex:0] integerValue];
                NSInteger g = [[elems objectAtIndex:1] integerValue];
                NSInteger b = [[elems objectAtIndex:2] integerValue];
                
                
                if (@available(iOS 10.0, *)) {
                    return  [UIColor colorWithDisplayP3Red:r/255.0 green:g/255.0f blue:b/255.0f alpha:1.0f];
                } else {
                    return  [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f];
                }
            }
        }
    }
    
    NSArray *    array = [string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *    color = [array objectAtIndex:0];
//    CGFloat        alpha = 1.0f;
    
    if ( array.count == 2 )
    {
        alpha = [[array objectAtIndex:1] floatValue];
    }
    
    if ( [color hasPrefix:@"#"] ) // #FFF
    {
        color = [color substringFromIndex:1];
        
        if ( color.length == 3 )
        {
            NSUInteger hexRGB = strtol(color.UTF8String , nil, 16);
            return [UIColor fromShortHexValue:hexRGB alpha:alpha];
        }
        else if ( color.length == 6 )
        {
            NSUInteger hexRGB = strtol(color.UTF8String , nil, 16);
            return [UIColor fromHexValue:hexRGB alpha:alpha];
        }
    }
    else if ( [color hasPrefix:@"0x"] || [color hasPrefix:@"0X"] ) // #FFF
    {
        color = [color substringFromIndex:2];
        
        if ( color.length == 8 )
        {
            NSUInteger hexRGB = strtol(color.UTF8String , nil, 16);
            return [UIColor fromHexValue:hexRGB];
        }
        else if ( color.length == 6 )
        {
            NSUInteger hexRGB = strtol(color.UTF8String , nil, 16);
            return [UIColor fromHexValue:hexRGB alpha:1.0f];
        }
    }
    else
    {
        static NSMutableDictionary * __colors = nil;
        
        if ( nil == __colors )
        {
            __colors = [[NSMutableDictionary alloc] init];
            [__colors setObject:[UIColor clearColor]        forKey:@"clear"];
            [__colors setObject:[UIColor clearColor]        forKey:@"transparent"];
            [__colors setObject:[UIColor redColor]            forKey:@"red"];
            [__colors setObject:[UIColor blackColor]        forKey:@"black"];
            [__colors setObject:[UIColor darkGrayColor]        forKey:@"darkgray"];
            [__colors setObject:[UIColor lightGrayColor]    forKey:@"lightgray"];
            [__colors setObject:[UIColor whiteColor]        forKey:@"white"];
            [__colors setObject:[UIColor grayColor]            forKey:@"gray"];
            [__colors setObject:[UIColor greenColor]        forKey:@"green"];
            [__colors setObject:[UIColor blueColor]            forKey:@"blue"];
            [__colors setObject:[UIColor cyanColor]            forKey:@"cyan"];
            [__colors setObject:[UIColor yellowColor]        forKey:@"yellow"];
            [__colors setObject:[UIColor magentaColor]        forKey:@"magenta"];
            [__colors setObject:[UIColor orangeColor]        forKey:@"orange"];
            [__colors setObject:[UIColor purpleColor]        forKey:@"purple"];
            [__colors setObject:[UIColor brownColor]        forKey:@"brown"];
        }
        
        UIColor * result = [__colors objectForKey:color.lowercaseString];
        if ( result )
        {
            return [result colorWithAlphaComponent:alpha];
        }
    }
    
    return nil;
}
//{
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
//}

+ (UIColor *)fromHexValue:(NSUInteger)hex
{
    NSUInteger a = ((hex >> 24) & 0x000000FF);
    float fa = ((0 == a) ? 1.0f : (a * 1.0f) / 255.0f);
    
    return [UIColor fromHexValue:hex alpha:fa];
}

+ (UIColor *)fromHexValue:(NSUInteger)hex alpha:(CGFloat)alpha
{
    if ( hex == 0xECE8E3 ) {
        
    }
    NSUInteger r = ((hex >> 16) & 0x000000FF);
    NSUInteger g = ((hex >> 8) & 0x000000FF);
    NSUInteger b = ((hex >> 0) & 0x000000FF);
    
    float fr = (r * 1.0f) / 255.0f;
    float fg = (g * 1.0f) / 255.0f;
    float fb = (b * 1.0f) / 255.0f;
    
    return [UIColor colorWithRed:fr green:fg blue:fb alpha:alpha];
}

+ (UIColor *)fromShortHexValue:(NSUInteger)hex
{
    return [UIColor fromShortHexValue:hex alpha:1.0f];
}

+ (UIColor *)fromShortHexValue:(NSUInteger)hex alpha:(CGFloat)alpha
{
    NSUInteger r = ((hex >> 8) & 0x0000000F);
    NSUInteger g = ((hex >> 4) & 0x0000000F);
    NSUInteger b = ((hex >> 0) & 0x0000000F);
    
    float fr = (r * 1.0f) / 15.0f;
    float fg = (g * 1.0f) / 15.0f;
    float fb = (b * 1.0f) / 15.0f;
    
    return [UIColor colorWithRed:fr green:fg blue:fb alpha:alpha];
}



@end
