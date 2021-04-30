//
//  LFInputTableViewCell.h
//  
//
//  Created by 孙凌锋 on 2020/2/25.
//  Copyright © 2020 孙凌锋. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BaseTextField.h"
#import "LFInputModel.h"
//#import "FSTextView.h"

NS_ASSUME_NONNULL_BEGIN
/// 我的-修改昵称、密码之类输入
@interface LFInputTableViewCell : UITableViewCell

@property (nonatomic, retain) UILabel *titleLabel;

@property (nonatomic, retain) BaseTextField *tf;

@property (nonatomic, retain) UIView *line;

@property (nonatomic, retain) UIImageView *rightIV;

@property (nonatomic, retain) LFInputModel *model;


@end
///标题  副标题 箭头
@interface LFInputItemTableViewCell : UITableViewCell

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *subLabel;
@property (nonatomic, retain) UIImageView *arrowIV;

@property (nonatomic, retain) UIImageView *rightIV;
@property (nonatomic, retain) LFInputModel *model;

@end

//@interface LFInputTitleTableViewCell : LFAngleTableViewCell
//@property (nonatomic, retain) UILabel *titleLabel;
//@property (nonatomic, retain) LFInputModel *model;
//
//@end
//
//@interface LFInputTextViewTableViewCell : UITableViewCell
//@property (nonatomic, retain) FSTextView *textView;
//@property (nonatomic, retain) LFInputModel *model;
//
//@end

@interface InputSwitchTableViewCell : UITableViewCell

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UISwitch *sh;
@property (nonatomic, retain) LFInputModel *model;
@end

///标题 剧中
@interface LFInputCenterTableViewCell : UITableViewCell

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) LFInputModel *model;

@end


NS_ASSUME_NONNULL_END
