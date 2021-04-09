//
//  UIButton+LF.h
//  Tool
//
//  Created by mac on 2021/4/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^OnClickBlock)(UIButton *btn);

typedef NS_ENUM(NSUInteger, MKButtonEdgeInsetsStyle) {

MKButtonEdgeInsetsStyleTop, // image在上，label在下

MKButtonEdgeInsetsStyleLeft, // image在左，label在右

MKButtonEdgeInsetsStyleBottom, // image在下，label在上

MKButtonEdgeInsetsStyleRight // image在右，label在左

};


@interface UIButton (LF)
@property (nonatomic, copy) OnClickBlock onClickBlock;

#pragma mark - 设置
- (instancetype)setWithFontSize:(NSInteger)fontSize fontColor:(UIColor *)color;

- (instancetype)setWithFontSize:(NSInteger)fontSize fontColor:(UIColor *)color text:(NSString *)text;

- (instancetype)setWithFontSize:(NSInteger)fontSize fontColor:(UIColor *)color text:(NSString *)text backg:(UIColor *)backg radius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

- (void)setBtnWithFontSize:(NSInteger)fontSize fontColor:(UIColor *)color backg:(UIColor *)backg;


//设置上图片 下标题
- (void)setImageTopAndTitleBottom:(NSString *)str;

/**
 
 *  设置button的titleLabel和imageView的布局样式，及间距
 
 *
 
 *  @param style titleLabel和imageView的布局样式
 
 *  @param space titleLabel和imageView的间距
 
 */

- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space;

@end

NS_ASSUME_NONNULL_END
