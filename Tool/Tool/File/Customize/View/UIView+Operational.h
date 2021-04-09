//
//  UIView+Operational.h
//  gxw
//
//  Created by 孙凌锋 on 2018/9/21.
//  Copyright © 2018年 孙凌锋. All rights reserved.
//

#import <UIKit/UIKit.h>

//NS_ASSUME_NONNULL_BEGIN

typedef void(^CQ_ViewTappedBlock)(void);
typedef void(^CQ_SubViewBlock)(NSInteger index);
typedef void(^LF_ViewTappedIDBlock)(id any);
typedef void(^LF_TapObjIDBlock)(id any, NSInteger index);
@interface UIView (Operational)
/** 单击手势事件回调的block */
@property (nonatomic, copy) CQ_ViewTappedBlock cq_viewTappedBlock;
//子试图 点击
@property (nonatomic, copy) CQ_SubViewBlock cq_subViewBlock;
//传递值
@property (nonatomic, copy) LF_ViewTappedIDBlock lf_ViewTappedIDBlock;

@property (nonatomic, copy) LF_TapObjIDBlock lF_TapObjIDBlock;

@property (nonatomic, retain) UITapGestureRecognizer *tapGesture;

/**
 与单击手势绑定的block
 
 @param tappedBlock 单击手势事件回调的block
 */
- (void)cq_whenTapped:(void(^)(void))tappedBlock;

@end

//NS_ASSUME_NONNULL_END
