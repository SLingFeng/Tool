//
//  LFTool.h
//  Tool
//
//  Created by slf on 2021/4/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


#define LFSTA_H  [[UIApplication sharedApplication] statusBarFrame].size.height

#define LFNAV_H  (KSTA_H + 44)

#define LFTAB_H  ([LFTool safeAreaHeight] + 49)

#define LFBOTTOM_H [LFTool safeAreaHeight]

typedef NS_ENUM(NSInteger, FontWeightStyle) {
    FontWeightStyleMedium, // 中黑体
    FontWeightStyleSemibold, // 中粗体
    FontWeightStyleLight, // 细体
    FontWeightStyleUltralight, // 极细体
    FontWeightStyleRegular, // 常规体
    FontWeightStyleThin, // 纤细体
};

@interface LFTool : NSObject

//获取底部安全距离
+ (CGFloat)safeAreaHeight;

//全面屏机型判断
+(BOOL)isFullScreenIphone;
///手机可用 总 空间
+ (NSArray *)getDivceFreeAndTotalSize;
///单个文件的大小
+ (long long)fileSizeAtPath:(NSString *)filePath;
///遍历文件夹获得文件夹大小
+ (long long)folderSizeAtPath:(NSString *)folderPath;
/// 返回具体的大小字符串
+ (NSString *)sizeOfFile:(long long)folderSize;

/**
 苹方字体

 @param fontWeight 字体粗细（字重)
 @param fontSize 字体大小
 @return 返回指定字重大小的苹方字体
 */
+ (UIFont *)pingFangSCWithWeight:(FontWeightStyle)fontWeight size:(CGFloat)fontSize;


@end

NS_ASSUME_NONNULL_END
