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


@end

NS_ASSUME_NONNULL_END
