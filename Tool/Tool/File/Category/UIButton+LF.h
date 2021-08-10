//
//  UIButton+LF.h
//  Tool
//
//  Created by mac on 2021/4/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^OnClickBlock)(UIButton *btn);
typedef void (^TimeFinishBlock)(UIButton * button);


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

- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space size:(CGSize)size;

//倒计时
@property (nonatomic, strong) dispatch_source_t timer;
//倒计时完成block
@property (nonatomic, strong) TimeFinishBlock timeFinishBlock;
@property (nonatomic, assign) NSInteger timeOutNumber;
/**
 * 倒计时
 *@param timeout 倒计时秒数
 *@param tittle 倒计时完成后button的文字，比如：重新获取验证码
 *@param waitTittle 倒计时单位 s m h
 *@param FColor 倒计时完成后button的颜色
 *@param WColor 倒计时过程中的button颜色
 */
- (void)lf_startCountDownTime:(NSInteger )timeout finishTitle:(NSString *)tittle waitTittle:(NSString *)waitTittle finishColor:(UIColor *)FColor waitColor:(UIColor *)WColor Finish:(TimeFinishBlock)timeBlock;

@end

NS_ASSUME_NONNULL_END
