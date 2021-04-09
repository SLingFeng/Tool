//
//  UILabel+LFLabel.h
//  Tool
//
//  Created by mac on 2021/4/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^OnTapLabelBlock)(UILabel *label);
@interface UILabel (LFLabel)

@property (nonatomic, copy) OnTapLabelBlock onTapBlock;

@end

NS_ASSUME_NONNULL_END
