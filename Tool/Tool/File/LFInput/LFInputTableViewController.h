//
//  LFInputTableViewController.h
//
//
//  Created by 孙凌锋 on 2020/2/24.
//  Copyright © 2020 孙凌锋. All rights reserved.
//

#import "BaseViewController.h"
#import "LFInputModel.h"
//#import "LFGradientButton.h"
#import "LFInputTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LFBaseTableViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView *tableView;

///不可重写
- (void)setUI:(UITableViewStyle)style;

@end

@interface LFInputTableViewController : LFBaseTableViewController


@property (nonatomic, retain) NSMutableArray *modelArr;

@end

///带有按钮
//@interface LFInputBtnViewController : LFInputTableViewController
/////默认文字：提交
//@property (nonatomic, retain) LFGradientButton *doneBtn;
//
//@end



NS_ASSUME_NONNULL_END
