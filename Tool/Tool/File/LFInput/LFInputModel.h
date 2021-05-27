//
//  LFInputModel.h
//  
//
//  Created by 孙凌锋 on 2020/2/21.
//  Copyright © 2020 孙凌锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseTextField.h"
//#import "LFButton.h"
//#import "LFInputAngleTableViewCell.h"
//#import "FSTextView.h"
#import <Masonry/Masonry.h>
#import "UIColor+Extension.h"

NS_ASSUME_NONNULL_BEGIN
@class LFInputAngleTableViewCell;

@interface LFInputModel : NSObject

/**
cell的状态
 0:LFInputAngleTableViewCell 选择
 1:LFInputAngleTableViewCell 输入
 
 2:LFInputTitleTableViewCell 标题
 -- 没有圆角 ⬇️--
 30:LFInputTableViewCell 标题 输入
 31:LFInputTableViewCell 只有输入 没有标题
 32:LFInputTableViewCell 有标题 tf不可输入
 33:LFInputTableViewCell 放获取验证码
 
 
 -- textview --
 4:
 -- 选择 --
 41:
 
 //我的-设置
 5
 
 6: LFInputItemTableViewCell
 
 7: InputSwitchTableViewCell
 
 ///标题 剧中
 8: LFInputCenterTableViewCell
 */

#pragma mark - 通用
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *title;
///可以把 id 改 相应的 cell
@property (nonatomic, copy) void(^cellDidClick)(id cell);
///默认0titlelabel左边 \\ 大于0是距离cell.mas_left的距离
@property (nonatomic, assign) CGFloat maxLeftSpace;

@property (nonatomic, assign) CGFloat rightSpace;

@property (nonatomic, assign) CGFloat rightLabelSpace;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, retain) id object;

#pragma mark - 输入cell


@property (nonatomic, copy) NSString *placeholder;

@property (nonatomic, copy) void(^textFieldDone)(UITextField *tf);

@property (nonatomic, copy) void(^textFieldChange)(UITextField *tf);
//用户输入文字保存起来
@property (nonatomic, copy) NSString *userEnterText;

@property (assign, nonatomic) NSInteger enterNumber;

@property (nonatomic) UIKeyboardType keyboardType;

@property(nonatomic) NSTextAlignment tfTextAlignment;



//@property (nonatomic, retain) FSTextView *textView;

#pragma mark - LFInputItemTableViewCell
//显示 *
@property (nonatomic, assign) BOOL isRequired;

#pragma mark - 群设置
//no关 yes开
@property (nonatomic, assign) BOOL switchOn;

@property (nonatomic, retain) UISwitch * sh;

#pragma mark - 我的-设置

@property (nonatomic, copy) NSString *subText;

@property (nonatomic, copy) NSString *rightText;

@property (nonatomic, retain) UIColor *rightTextColor;

///右边箭头显示，默认NO显示
@property (nonatomic, assign) BOOL arrowHidden;

@property (nonatomic, copy) void(^switchChange)(UISwitch *sh);

///放获取验证码
@property (nonatomic, retain) UIView *codeView;

@property (nonatomic, retain) UIView *customView;

///标题 剧中 8: LFInputCenterTableViewCell

@property (nonatomic, retain) UIColor *inputCenterColor;
///标题左边图片
@property (nonatomic, retain) UIView *inputCenterLeftView;

#pragma mark -
@property (nonatomic, assign) BOOL rightIVHidden;
///只显示右边图片
@property (nonatomic, copy) NSString *leftImageName;
///CGSizeMake(15, 15)
@property (nonatomic, assign) CGSize leftImageSize;

@property (nonatomic, copy) NSString *titleForHeaderInSection;

@property (nonatomic, assign) CGFloat heightForHeaderInSection;
//@property (nonatomic, copy) void(^FSTextViewHandler)(FSTextView *textView);

//@property (nonatomic, copy) void(^selectIDBlock)(NSString *ids);

//@property (nonatomic, copy) void(^onClickBlock)(LFButton *sender);


//@property (assign, nonatomic) BaseTextFieldEnterType enterType;

//@property (nonatomic, retain) NSMutableArray *mulitpleData;
//@property (nonatomic, copy) NSString *btnTitle;
@end

NS_ASSUME_NONNULL_END
