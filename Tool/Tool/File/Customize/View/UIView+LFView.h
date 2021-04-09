//
//  UIView+LFView.h
//  Tool
//
//  Created by mac on 2021/4/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^OnTapViewBlock)(UIView *view);

@interface UIView (LFView)
@property (nonatomic, copy) OnTapViewBlock onTapViewBlock;

@end

NS_ASSUME_NONNULL_END
