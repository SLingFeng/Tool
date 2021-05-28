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
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    __weak __typeof(&*self) weakSelf = self;
//    
//    GHStorageTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHStorageTopTableViewCell"];
//    
//    [cell reload:indexPath.section];
//    if (indexPath.section == 0) {
//        NSString *documentPath = [IMKitFileLocationHelper userDirectory];
//        long long q1 = [LFTool folderSizeAtPath:documentPath];
//        
//        long long q2 = [LFTool folderSizeAtPath:[QDFileHandler SDKDir]];
//        
//        long long q3 = [LFTool folderSizeAtPath:[IMKitFileLocationHelper getAppTempPath]];
//                
//        NSNumber * use = [NSNumber numberWithLongLong:(q1 + q2 + q3)];
//
//        NSNumber * total = [LFTool getDivceFreeAndTotalSize].lastObject;
//
//        double a = use.doubleValue / 1024 / 1024 / 1024;
//        double b = total.doubleValue / 1024 / 1024 / 1024;
//        double per = a / b * 100;
//
//        cell.topLabel.text = @"已用空间";
//        cell.centerLabel.text = [LFTool sizeOfFile:use.longLongValue];
//        cell.bottomLabel.text = [NSString stringWithFormat:@"占据手机%.3f%%存储空间", per];
//        
//    } else if (indexPath.section == 1) {
//        cell.topLabel.text = @"聊天记录";
//        cell.centerLabel.text = @"0";
//        cell.bottomLabel.text = @"可清理聊天中的图片、视频、文件等数据，但不会删除消息。";
//        
//    } else if (indexPath.section == 2) {
//
//        long long a = [LFTool folderSizeAtPath:[QDFileHandler SDKDir]];
//        
//        long long b = [LFTool folderSizeAtPath:[IMKitFileLocationHelper getAppTempPath]];
//        
//        long long c = [LFTool folderSizeAtPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0]];
//        
//        long long d = [[SDImageCache sharedImageCache] totalDiskSize];
//        
//        NSNumber * tu = [NSNumber numberWithLongLong:(a + b + c + d)];
//        
//        cell.topLabel.text = @"缓存";
//        cell.centerLabel.text = [LFTool sizeOfFile:tu.longLongValue];
//        cell.bottomLabel.text = @"缓存是使用软件过程中产生的临时数据，清理缓存不会影响软件的正常使用。";
//
//        cell.doBtn.onClickBlock = ^(UIButton * _Nonnull btn) {
//            [SLFAlert showSystemAlertWithTitle:@"确定清理缓存?" text:nil determineTitle:@"清理" cancelTitle:@"取消" alertClick:^(BOOL rightClick) {
//                if (rightClick) {
//                    [weakSelf clearFileCache];
//                }
//            }];
//        };
//    }
//    return cell;
//
//}
//
//- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
//    return NO;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return UITableViewAutomaticDimension;
//}
//
//- (void)clearFileCache {
//    
//    [[HUD shareHUD] showWait:@"正在清除"];
//    
//    [self removeAndCreate:[QDFileHandler SDKDir]];
//    
//    [self removeAndCreate:[IMKitFileLocationHelper getAppTempPath]];
//
//    [NSObject clearTheCache];
//    
//    [[YunPanDownloadManager instance] clear];
//    
////    @weakify(self);
//    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
////        @strongify(self);
//        
//        [[HUD shareHUD] hideWait];
//        
//        [[HUD shareHUD] showText:@"清除成功"];
//                
//    }];
//}
//
//- (void)removeAndCreate:(NSString *)tolatPath {
//
//    NSDirectoryEnumerator *docEnumerator   = [[NSFileManager defaultManager] enumeratorAtPath:tolatPath];
//    
//    for (NSString *fileName in docEnumerator) {
//        NSString *fileDirPath = [tolatPath stringByAppendingPathComponent:fileName];
//        [[NSFileManager defaultManager] removeItemAtPath:fileDirPath error:nil];
//        [[NSFileManager defaultManager] createDirectoryAtPath:fileDirPath withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//}

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
