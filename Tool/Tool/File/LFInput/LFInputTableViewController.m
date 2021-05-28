//
//  LFInputTableViewController.m
//
//
//  Created by 孙凌锋 on 2020/2/24.
//  Copyright © 2020 孙凌锋. All rights reserved.
//

#import "LFInputTableViewController.h"

@implementation LFBaseTableViewController

- (void)setUI:(UITableViewStyle)style {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(style)];
    [self.view addSubview:_tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = KBGCOLOR;
    self.tableView.backgroundColor = [UIColor colorHex:@"#F8F9FB"];
    self.tableView.separatorStyle = 1;
    [self.tableView setSeparatorColor:kLineColor];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
//    if (@available(iOS 11.0, *)) {
//        self.tableView.estimatedSectionHeaderHeight = 0.01;
//        self.tableView.estimatedSectionFooterHeight = 0.01;
//    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end

#pragma mark - LFInputTableViewController
@interface LFInputTableViewController ()

@end

@implementation LFInputTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.modelArr = [NSMutableArray arrayWithCapacity:10];

    
}

- (void)setUI:(UITableViewStyle)style {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(style)];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = KBGCOLOR;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.tableView registerClass:[LFInputTableViewCell class] forCellReuseIdentifier:@"LFInputTableViewCell"];
    [self.tableView registerClass:[LFInputItemTableViewCell class] forCellReuseIdentifier:@"LFInputItemTableViewCell"];
    [self.tableView registerClass:[InputSwitchTableViewCell class] forCellReuseIdentifier:@"InputSwitchTableViewCell"];
    [self.tableView registerClass:[LFInputCenterTableViewCell class] forCellReuseIdentifier:@"LFInputCenterTableViewCell"];
    [self.tableView registerClass:[LFInputTextViewTableViewCell class] forCellReuseIdentifier:@"LFInputTextViewTableViewCell"];
    
//    if (@available(iOS 11.0, *)) {
//        self.tableView.estimatedSectionHeaderHeight = 0.01;
//        self.tableView.estimatedSectionFooterHeight = 0.01;
//    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.modelArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.modelArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LFInputModel *model = self.modelArr[indexPath.section][indexPath.row];
    
    if (model.type == 4) {
        LFInputTextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LFInputTextViewTableViewCell"];
        cell.model = model;
        return cell;
        
    }else if (model.type == 6) {
        LFInputItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LFInputItemTableViewCell"];

        cell.model = model;
        return cell;
    }else if (model.type == 7) {
        InputSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InputSwitchTableViewCell"];

        cell.model = model;
        return cell;
    }else if (model.type == 8) {
        LFInputCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LFInputCenterTableViewCell"];

        cell.model = model;
        return cell;
    }
    LFInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LFInputTableViewCell"];

    cell.model = model;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LFInputModel *model = self.modelArr[indexPath.section][indexPath.row];
    return model.cellHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    LFInputModel * model = self.modelArr[indexPath.section][indexPath.row];
    if (model.cellDidClick) {
        model.cellDidClick([tableView cellForRowAtIndexPath:indexPath]);
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    LFInputModel * model = self.modelArr[indexPath.section][indexPath.row];
    if (model.cellDidClick) {
        return 1;
    }
    return 0;
}

//组头文字提示
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    if (self.modelArr.count > section) {
//        LFInputModel *model = [self.modelArr[section] firstObject];
//        return model.titleForHeaderInSection;
//    }
//    return nil;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    LFInputModel *model = [self.modelArr[section] firstObject];
    if (model.titleForHeaderInSection == nil || [model.titleForHeaderInSection isEqualToString:@""]) {
        return 0;
    }
    CGFloat h = [model.titleForHeaderInSection sizeWithFont:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(kScreenW - 30, CGFLOAT_MAX)].height + 20;
    if (model.heightForHeaderInSection > h) {
        return model.heightForHeaderInSection;
    }else {
        return h;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.modelArr.count > section) {
        LFInputModel *model = [self.modelArr[section] firstObject];
        
        UIView *view = [[UIView alloc] init];
        
        UILabel * label = [[UILabel alloc] init];
        label.textColor = [UIColor text99Color];
        label.font = [UIFont systemFontOfSize:12];
        [view addSubview:label];
        label.numberOfLines = 0;
        label.text = model.titleForHeaderInSection;
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.offset(15);
            make.right.offset(-15);
        }];
        
        return view;
    }
    return nil;
}

@end

//@implementation LFInputBtnViewController
//
//- (void)setUI {
//    [super setUI];
//    
//    self.view.backgroundColor = [UIColor whiteColor];
//    self.tableView.backgroundColor = [UIColor whiteColor];
//    
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    
//    self.tableView.separatorColor = assist_line_color;
//    self.tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16);
//
//
//    [self.tableView registerClass:[LFInputTableViewCell class] forCellReuseIdentifier:@"LFInputTableViewCell"];
//    
//    UIView *view = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, 66))];
//
//    self.doneBtn = [[LFGradientButton alloc] initWithFontSize:17 fontColor:[UIColor whiteColor] fontText:@"提交"];
//    [view addSubview:self.doneBtn];
//    ViewRadius(self.doneBtn, 23);
//    [self.doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.centerX.mas_equalTo(0);
//        make.left.offset(16).priorityMedium();
//        make.right.offset(-16).priorityMedium();
//        make.height.mas_equalTo(46);
//        make.top.offset(20);
//    }];
////    line.backgroundColor = ;
//    self.tableView.tableFooterView = view;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    LFInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LFInputTableViewCell"];
//    LFInputModel * model = self.modelArr[indexPath.section][indexPath.row];
//    
//    cell.model = model;
//    
//    return cell;
//}
/////最后一行加上线
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    
//    if (section == self.modelArr.count - 1) {
//        UIView *view = [[UIView alloc] init];
//        view.backgroundColor = [UIColor whiteColor];
//
//        UIView *line = [[UIView alloc] initWithFrame:(CGRectMake(16, 0, SCREEN_WIDTH - 32, 0.5))];
//        line.backgroundColor = assist_line_color;
//        [view addSubview:line];
//        return view;
//    }
//    return nil;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    if (section == self.modelArr.count - 1) {
//        return 10;
//    }
//    return 0;
//}
//
//@end


