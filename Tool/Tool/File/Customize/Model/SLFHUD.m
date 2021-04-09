//
//  SLFHUD.m
//
//  Copyright © 2017年 孙凌锋. All rights reserved.
//

/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */

#import "SLFHUD.h"


#import <objc/runtime.h>

static const void *SLFHttpRequestHUDKey = &SLFHttpRequestHUDKey;
static SLFHUD * _HUD = nil;

@implementation SLFHUD

+(SLFHUD *)share {
    @synchronized(self){
        if (_HUD == nil) {
            //重写 alloc
            _HUD = [[super allocWithZone:NULL]init];
        }
        return _HUD;
    }
}
//重写 alloc
+(id)allocWithZone:(struct _NSZone *)zone{
    return [self share];
}
//重写 copy
+(id)copyWithZone:(struct _NSZone *)zone{
    return self;
}

+ (MBProgressHUD *)Hud {
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    if (kObjectIsEmpty(hud)) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    [hud setRemoveFromSuperViewOnHide:1];
    [[SLFHUD share] setHUD:hud];
    return hud;
}

- (void)setHUD:(MBProgressHUD *)HUD {
    objc_setAssociatedObject(_HUD, SLFHttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)showHudInView:(UIView *)view hint:(NSString *)hint {
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.label.text = hint;
    [view addSubview:HUD];
    [HUD showAnimated:YES];
    [[SLFHUD share] setHUD:HUD];
}

+ (void)showLoadingHint:(NSString *)hint {
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = hint;
    [hud showAnimated:YES];
    [[SLFHUD share] setHUD:hud];
}

+ (void)showLoading {
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [hud showAnimated:YES];
    [[SLFHUD share] setHUD:hud];
}

+ (void)showHint:(NSString *)hint {
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
//    hud.margin = 10.f;
//    hud.yOffset = 180;
    hud.removeFromSuperViewOnHide = YES;
//    [hud hide:YES afterDelay:2];
    [hud hideAnimated:YES afterDelay:2];
}

+ (void)showHint:(NSString *)hint delay:(NSTimeInterval)delay {
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    hud.margin = 10.f;
    //    hud.yOffset = 180;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:delay];
}

+ (void)showHint:(NSString *)hint yOffset:(float)yOffset {
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    hud.margin = 10.f;
//    hud.yOffset = 180;
//    hud.yOffset += yOffset;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
}

+ (void)hideHud {
    UIView *view = [[UIApplication sharedApplication].delegate window];
    [MBProgressHUD hideHUDForView:view animated:YES];
    [[SLFHUD Hud] hideAnimated:YES];
}

+ (void)showHint:(NSString *)hint delay:(NSTimeInterval)delay completion:(completionBlock)block {
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.delegate = [SLFHUD share];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    [hud hideAnimated:YES afterDelay:delay];
    [SLFHUD share].completion = ^() {
        hud.delegate = nil;
        if (block) {
            block();
        }
    };
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
    if ([SLFHUD share].completion) {
        [SLFHUD share].completion();
    }
}

+ (MBProgressHUD *)showAnnularHint:(NSString *)hint {
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = hint;
    [[SLFHUD share] setHUD:hud];
    return hud;
}

+ (MBProgressHUD *)showLoadingImageHint:(NSString *)hint {
    // 禁止TableView滚动
//    if ([view respondsToSelector:@selector(setScrollEnabled:)]) {
//        [(UIScrollView*)view setScrollEnabled:NO];
//    }
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *HUDInView = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUDInView.center=CGPointMake(view.center.x, view.center.y - view.frame.origin.y);
    HUDInView.removeFromSuperViewOnHide = YES;
    HUDInView.label.text = hint;
    HUDInView.square = YES;
    HUDInView.mode = MBProgressHUDModeCustomView;
    HUDInView.layer.cornerRadius=4.0f;
    HUDInView.layer.masksToBounds=YES;
    HUDInView.alpha=1.00;
//    HUDInView.yOffset=5;
    HUDInView.label.font=[UIFont boldSystemFontOfSize:14.0f];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, 50, 50);
//    NSMutableArray *imageList = [[NSMutableArray alloc] initWithCapacity:34];
//    for (NSInteger i = 1; i <= 36; i++) {
//        UIImage *frameImage = [UIImage imageNamed:[NSString stringWithFormat:@"loading_000%ld",(long)i]];
//        if (frameImage) {
//            [imageList addObject:frameImage];
//        }
//    }
//    [imageView setAnimationImages:imageList];
//    [imageView setAnimationDuration:1];
//    [imageView startAnimating];
    
    HUDInView.customView = imageView;
    [[SLFHUD share] setHUD:HUDInView];
    return HUDInView;
}

@end
