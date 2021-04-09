//
//  TKInputTableViewController.h
//  TaoKe
//
//  Created by 孙凌锋 on 2020/2/24.
//  Copyright © 2020 MostOne. All rights reserved.
//

#import "MyBaseViewController.h"
#import "TKInputModel.h"
//#import "TKGradientButton.h"
#import "TKInputTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface TKInputTableViewController : MyBaseViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) NSMutableArray *modelArr;
///不可重写
- (void)setUI;
@end

///带有按钮
//@interface TKInputBtnViewController : TKInputTableViewController
/////默认文字：提交
//@property (nonatomic, retain) TKGradientButton *doneBtn;
//
//@end

NS_ASSUME_NONNULL_END
