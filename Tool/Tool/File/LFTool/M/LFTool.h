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


@end

NS_ASSUME_NONNULL_END
