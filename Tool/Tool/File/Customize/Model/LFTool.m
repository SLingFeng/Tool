//
//  LFTool.m
//  Tool
//
//  Created by slf on 2021/4/28.
//

#import "LFTool.h"

@implementation LFTool

//获取底部安全距离
+ (CGFloat)safeAreaHeight {
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        return mainWindow.safeAreaInsets.bottom;
    }
    return 0;
}
//全面屏机型判断
+(BOOL)isFullScreenIphone {
    BOOL isFullIphone = NO;
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            isFullIphone = YES;
        }
    }
    return isFullIphone;
}

+ (NSArray *)getDivceFreeAndTotalSize {
//    /// 总大小
//    float totalsize = 0.0;
//    /// 剩余大小
//    float freesize = 0.0;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    if (dictionary)
    {
        NSNumber *_free = [dictionary objectForKey:NSFileSystemFreeSize];
//        freesize = [_free unsignedLongLongValue]*1.0;
        
        NSNumber *_total = [dictionary objectForKey:NSFileSystemSize];
//        totalsize = [_total unsignedLongLongValue]*1.0;
        return @[_free, _total];

    } else {
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
        return @[@(0), @(0)];

    }
//    NSString * sizeStr = [NSString stringWithFormat:@"可用空间%0.2fG / 总空间%0.2fG",freesize, totalsize];
//    NSLog(@"%@", sizeStr);
//    NSNumber * total = [LFTool getDivceFreeAndTotalSize].lastObject;
//
//    double a = use.doubleValue / 1024 / 1024 / 1024;
//    double b = total.doubleValue / 1024 / 1024 / 1024;
//    double per = a / b * 100;
}

///单个文件的大小
+ (long long)fileSizeAtPath:(NSString *)filePath {

    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

///遍历文件夹获得文件夹大小
+ (long long)folderSizeAtPath:(NSString *)folderPath {
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:folderPath]) return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    
    NSString* fileName;
    
    long long folderSize = 0;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        
        folderSize += [LFTool fileSizeAtPath:fileAbsolutePath];
        
    }
    return  folderSize;
}
/// 返回具体的大小字符串
+ (NSString *)sizeOfFile:(long long)folderSize {

    if (folderSize < 1024.0) {
        return  [NSString stringWithFormat:@"%.2fB",folderSize * 1.0];
    }else if (folderSize >= 1024.0 && folderSize < (1024.0*1024.0)){
        return  [NSString stringWithFormat:@"%.2fKB",folderSize/1024.0];
    }if (folderSize >= (1024.0*1024.0) && folderSize < (1024.0*1024.0*1024.0)) {
        return [NSString stringWithFormat:@"%.2fMB", folderSize/(1024.0*1024.0)];
    }else{
        return [NSString stringWithFormat:@"%.2fGB", folderSize/(1024.0*1024.0*1024.0)];
    }
}

@end
