//
//  ShuRuKuangTFView.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyLabel.h"
#import "BaseTextField.h"

//#import <IQKeyboardManager/IQPreviousNextView.h>
@interface ShuRuKuangTFView : UIView
@property (strong, nonatomic) BaseTextField * TextField;
@property (retain, nonatomic) MyLabel * titleLabel;
@property (assign, nonatomic) BOOL isShangHu;
/**
 被选中的btn的tag
 */
@property (assign, nonatomic) NSInteger isSelectBtn;
/**
 输入的字符数量
 */
@property (assign, nonatomic) NSInteger enterNumber;
/**
 提示空的语句
 */
@property (copy, nonatomic) NSString * hudText;


@property (copy, nonatomic) void(^btnClickChange)(void);
/**
 initWithSelect的点击方法
 */
@property (copy, nonatomic) void(^selectBtnClick)(NSInteger tag);
/**
 取消选中btn的效果
 */
-(void)setDeSelectBtn;
/**
 带图片、文字和输入框view

 @param titleText       label文字
 @param placeholderText 输入框 等待文字
 @param image           label前的图片
 @param custom          自定义view

 @return view
 */
-(instancetype)initWithTitle:(NSString *)titleText placeholder:(NSString *)placeholderText image:(NSString *)image custom:(UIView *)custom;
-(instancetype)initWithSelect;
-(instancetype)initWithSelectArr:(NSArray *)titles;
//-(instancetype)initWithSelectBtnArr:(NSArray *)titles;
-(instancetype)initWithSelect:(NSString *)titleText;
-(instancetype)initWithSelectToPay:(NSString *)titleText;
-(instancetype)initWithSelectTitleArr:(NSArray *)titles imageArr:(NSArray <NSString *>*)imageArr;


-(void)createToTitle:(NSString *)titleText placeholder:(NSString *)placeholderText image:(NSString *)image custom:(UIView *)custom;
@end
