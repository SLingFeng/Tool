//
//  ShuRuKuangTFView.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "ShuRuKuangTFView.h"

@interface ShuRuKuangTFView ()
{
    //商户
//    BOOL isShangHu;
    UIImageView * _selectView;
    UIButton * _lastBtn;
    UIView * _view;
    NSMutableArray *_btnArr;
}
@end

@implementation ShuRuKuangTFView

-(instancetype)initWithTitle:(NSString *)titleText placeholder:(NSString *)placeholderText image:(NSString *)image custom:(UIView *)custom {
    if (self = [super init]) {
        [self createToTitle:titleText placeholder:placeholderText image:image custom:custom];
    }
    return self;
}

-(void)createToTitle:(NSString *)titleText placeholder:(NSString *)placeholderText image:(NSString *)image custom:(UIView *)custom {
//    self.layer.cornerRadius = 7.5f;
//    self.layer.masksToBounds = 1;
//    self.backgroundColor = [UIColor whiteColor];
    UIView *line = [[UIView alloc] init];
    [self addSubview:line];
    line.backgroundColor = kF5F5F5;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.offset(0);
        make.height.mas_equalTo(0.5);
    }];
    
    kWEAKSELF(weakSelf);
    UIImageView * imageView = nil;
    if (image != nil) {
        imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:image];
        [self addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset(15);
            make.width.mas_equalTo(@18);
            make.height.mas_equalTo(@20);
//            make.size.mas_equalTo(@20);
            make.centerY.mas_equalTo(weakSelf.mas_centerY);
        }];
    }
    
    BaseTextField * tf = [[BaseTextField alloc] init];
    [self addSubview:tf];
    self.TextField = tf;
    _TextField.placeholder = placeholderText;
    _TextField.font = [SLFCommonTools pxFont:32];

    _TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    MyLabel * title = nil;
    if (!kStringIsEmpty(titleText)) {
        title = [[MyLabel alloc] init];
        title.text = titleText;
        title.font = [SLFCommonTools pxFont:30];
        [self addSubview:title];
        self.titleLabel = title;
        CGSize size =[titleText sizeWithAttributes:@{NSFontAttributeName:title.font}];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            if (image != nil) {
                make.left.equalTo(imageView.mas_right).with.offset(5);
            }else {
                make.left.offset(10);
            }
            make.centerY.equalTo(weakSelf);
            if (placeholderText != nil) {
                make.size.mas_equalTo(CGSizeMake(size.width+2, size.height));
            }else {
                make.size.mas_equalTo(CGSizeMake(size.width+1, size.height));
            }
        }];
        _titleLabel = title;
    }else {
        
    }
    if (custom != nil) {
        [self addSubview:custom];
        CGFloat cw = custom.size.width;
        [custom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf);
            make.right.equalTo(weakSelf.mas_right).offset(-15);
            make.width.mas_equalTo(cw);
            make.height.mas_equalTo(25);
        }];
        
        [_TextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf);
            if (title != nil) {
                make.left.equalTo(title.mas_right).with.offset(5);
            }else if (imageView != nil) {
                make.left.equalTo(imageView.mas_right).with.offset(5);
            }else {
                make.left.offset(0);
            }
            make.right.equalTo(custom.mas_left).with.offset(1);
            make.top.bottom.offset(0);
        }];
    }else {
        [_TextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf);
            if (title != nil) {
                make.left.equalTo(title.mas_right).with.offset(5);
            }else if (imageView != nil) {
                make.left.equalTo(imageView.mas_right).with.offset(5);
            }else {
                make.left.offset(0);
            }
            make.right.equalTo(weakSelf.mas_right).with.offset(-1);
            make.top.bottom.offset(0);
        }];
    }
}

-(void)endTextField:(UITextField *)textField {
    if (_TextField == textField) {
        if ([SLFCommonTools kongGe:textField.text]) {
            if (self.hudText) {
                [SLFHUD showHint:self.hudText delay:1 completion:^{
                    [textField resignFirstResponder];
                }];
            }
        }
    }
}

-(void)setEnterNumber:(NSInteger)enterNumber {
    if (_enterNumber != enterNumber) {
        _enterNumber = enterNumber;
    }
}


#pragma -
-(instancetype)initWithSelect {
    if (self = [super init]) {
        kWEAKSELF(weakSelf);
        NSArray * title;
//        if ([SLFCommonTools isUserType]) {
//            title = @[@"统计考勤", @"请假审批"];
//        }else {
//            title = @[@"上课考勤", @"申请请假"];
//        }
        NSArray *images = @[@"统计考勤", @"请假审批"];
        
        for (int i=0; i<2;i++) {
            UIButton * btn = [[UIButton alloc] init];
            btn.tag = i+10;
            [self addSubview:btn];
            
            btn.titleLabel.font = [SLFCommonTools pxFont:32];
            [btn setTitle:title[i] forState:(UIControlStateNormal)];
            [btn setTitleColor:RGBCOLOR(51, 51, 51) forState:(UIControlStateNormal)];
            [btn setImage:[UIImage imageNamed:images[i]] forState:(UIControlStateNormal)];
            [btn setImage:[UIImage imageNamed:images[i]] forState:(UIControlStateSelected)];
            [btn addTarget:self action:@selector(selectClassClick:) forControlEvents:(UIControlEventTouchUpInside)];
            if (i == 0) {
                btn.selected = 1;
//                [SLFCommonTools lineDash:self hight:65 x:kScreenW/2-12 y:9.5 color:kLineColor lineW:0.5];
            }
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(CGRectGetWidth(weakSelf.frame)/2));
                //.with.offset(CGRectGetWidth(weakSelf.frame)/2*i);
                if (i == 0) {
                    make.left.equalTo(weakSelf).with.offset(0);
                    make.right.equalTo(weakSelf.mas_centerX);
                }else {
                    make.left.equalTo(weakSelf.mas_centerX);
                    make.right.equalTo(@(CGRectGetWidth(weakSelf.frame)));
                }
                make.top.and.bottom.equalTo(weakSelf).with.offset(0);
            }];
            
        }
    }
    return self;
}

-(instancetype)initWithSelectTitleArr:(NSArray *)titles imageArr:(NSArray <NSString *>*)imageArr {
    if (self = [super init]) {
//        kWEAKSELF(weakSelf);
        UIImageView * select = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"登录选择状态"]];
        [self addSubview:select];
        select.backgroundColor = [UIColor getNavBarColor];
        _selectView = select;
        for (int i=0; i<titles.count;i++) {
            UIButton * btn = [[UIButton alloc] init];
            btn.tag = i+10;
            [self addSubview:btn];
            
            btn.titleLabel.font = [SLFCommonTools pxFont:32];
            [btn setTitle:titles[i] forState:(UIControlStateNormal)];
            [btn setTitleColor:RGBCOLOR(51, 51, 51) forState:(UIControlStateNormal)];
            if (imageArr != nil || imageArr.count != 0) {
                [btn setImage:[UIImage imageNamed:imageArr[i]] forState:(UIControlStateNormal)];
                [btn setImage:[UIImage imageNamed:imageArr[i]] forState:(UIControlStateSelected)];
            }
            [btn addTarget:self action:@selector(selectClassClick:) forControlEvents:(UIControlEventTouchUpInside)];
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
            float w = kScreenW/titles.count;
            float x = JGG_X(0, w, 0, i, 3);
            float y = JGG_Y(0, 50, 0, i, 3);
            btn.frame = CGRectMake(x, y, w, 50);
            if (i == 0) {
                btn.selected = 1;
//                [SLFCommonTools lineDash:self hight:40 x:w y:5 color:kLineColor lineW:0.5];
            }else if (i==1) {
//                [SLFCommonTools lineDash:self hight:40 x:w*2 y:5 color:kLineColor lineW:0.5];
            }
//            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.width.equalTo(@(CGRectGetWidth(weakSelf.frame)/2));
//                if (i == 0) {
//                    make.left.equalTo(weakSelf).with.offset(0);
//                    make.right.equalTo(weakSelf.mas_centerX);
//                }else {
//                    make.left.equalTo(weakSelf.mas_centerX);
//                    make.right.equalTo(@(CGRectGetWidth(weakSelf.frame)));
//                }
//                make.top.and.bottom.equalTo(weakSelf).with.offset(0);
//            }];
            if (i == 0) {
                select.sd_layout.bottomSpaceToView(self, 0).widthIs(ISiPhone5?70:100).heightIs(3).centerXEqualToView(btn);
            }
        }
//        [SLFCommonTools line:self y:50 leftSpace:0 rightSpace:kContentViewWidth color:kLineColor lineW:0.5];
    }
    return self;
}

-(instancetype)initWithSelectArr:(NSArray *)titles {
    if (self = [super init]) {
        kWEAKSELF(weakSelf);
//        [SLFCommonTools line:self y:40 space:0 color:kLineColor lineW:0.5];
        [SLFCommonTools line:self y:44 leftSpace:0 rightSpace:kScreenW color:@"bfbfbf" lineW:0.5];
        [SLFCommonTools lineDash:self hight:24 x:kScreenW/2 y:10 color:@"bfbfbf" lineW:0.5];
        UIImageView * select = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"登录选择状态"]];
        [self addSubview:select];
        _selectView = select;
        
        for (int i=0; i<2;i++) {
            UIButton * btn = [[UIButton alloc] init];
            btn.tag = i+10;
            [self addSubview:btn];
            
            btn.titleLabel.font = [SLFCommonTools pxFont:32];
            [btn setTitle:titles[i] forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor colorHex:@"#bfbfbf"] forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor colorHex:@"#ff0000"] forState:(UIControlStateSelected)];
            [btn addTarget:self action:@selector(selectClassClick:) forControlEvents:(UIControlEventTouchUpInside)];
            
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(CGRectGetWidth(weakSelf.frame)/2));
                //.with.offset(CGRectGetWidth(weakSelf.frame)/2*i);
                if (i == 0) {
                    make.left.equalTo(weakSelf).with.offset(0);
                    make.right.equalTo(weakSelf.mas_centerX);
                }else {
                    make.left.equalTo(weakSelf.mas_centerX);
                    make.right.equalTo(@(CGRectGetWidth(weakSelf.frame)));
                }
                make.top.equalTo(weakSelf).with.offset(0);
                make.bottom.offset(0);
            }];
            if (i == 0) {
                btn.selected = 1;
                _lastBtn = btn;
                select.sd_layout.bottomSpaceToView(self, 3).widthIs(100).heightIs(7.5).centerXEqualToView(btn);
            }
        }
        
    }
    return self;
}
//-(instancetype)initWithSelectBtnArr:(NSArray *)titles{
//    if (self = [super init]) {
//        kWEAKSELF(weakSelf);
//        CGFloat w = kScreenW / titles.count;
//        //        [SLFCommonTools line:self y:40 space:0 color:kLineColor lineW:0.5];
////        [SLFCommonTools line:self y:40 leftSpace:0 rightSpace:kScreenW-45 color:kLineColor lineW:0.5];
//        UIImageView * select = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
//        [self addSubview:select];
//        select.backgroundColor = kBED500;
//        _selectView = select;
//
//        _btnArr = [NSMutableArray arrayWithCapacity:titles.count];
//        UIView *l;
//        for (int i=0; i<titles.count;i++) {
//            UIButton * btn = [[UIButton alloc] init];
//            btn.tag = i+10;
//            [self addSubview:btn];
//
//            btn.titleLabel.font = [SLFCommonTools pxFont:32];
//            [btn setTitle:titles[i] forState:(UIControlStateNormal)];
//            [btn setTitleColor:self.btnTextColor forState:(UIControlStateNormal)];
//            [btn setTitleColor:self.selcectBtnTextColor forState:(UIControlStateSelected)];
//            [btn addTarget:self action:@selector(selectClassClick:) forControlEvents:(UIControlEventTouchUpInside)];
//
//            btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
//
//            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.width.mas_equalTo(w);
//                //.with.offset(CGRectGetWidth(weakSelf.frame)/2*i);
//                if (i == 0) {
//                    make.left.equalTo(weakSelf).with.offset(0);
////                    make.right.equalTo(weakSelf.mas_centerX);
//                }else {
//                    make.left.equalTo(l.mas_right);
////                    make.right.equalTo(@(CGRectGetWidth(weakSelf.frame)));
//                }
//                make.top.bottom.offset(0);
//            }];
//            if (i == 0) {
//                btn.selected = 1;
//                _lastBtn = btn;
//                select.sd_layout.bottomSpaceToView(self, 1).widthIs(65).heightIs(3).centerXEqualToView(btn);
//            }
//            l = btn;
//            [_btnArr addObject:btn];
//        }
//
//    }
//    return self;
//}

//- (void)setBtnTextColor:(UIColor *)btnTextColor {
//    _btnTextColor = btnTextColor;
//    for (UIButton *b in _btnArr) {
//        [b setTitleColor:self.btnTextColor forState:(UIControlStateNormal)];
//    }
//}

//- (void)setSelcectBtnTextColor:(UIColor *)selcectBtnTextColor {
//    _selcectBtnTextColor = selcectBtnTextColor;
//    for (UIButton *b in _btnArr) {
//        [b setTitleColor:self.selcectBtnTextColor forState:(UIControlStateSelected)];
//    }
//}


-(void)selectClassClick:(UIButton *)btn {
//    if (_lastBtn == btn) {
//        return;
//    }
    
    for (UIButton *b in _btnArr) {
        b.selected = NO;
    }
    _lastBtn = btn;
    self.isSelectBtn = btn.tag - 10;
    if (self.selectBtnClick) {
        self.selectBtnClick(btn.tag-10);
    }
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint p = self->_selectView.center;
        p.x = btn.centerX;
        self->_selectView.center = p;
//        self->_selectView.centerX = btn.centerX;
    }];
    btn.selected = YES;
    
    if (btn.tag == 10) {
        //个人
        UIButton * tempBtn = [self viewWithTag:11];
        tempBtn.selected = NO;
    }else {
        //商户
        UIButton * tempBtn = [self viewWithTag:10];
        tempBtn.selected = NO;
    }
}

- (void)setIsSelectBtn:(NSInteger)isSelectBtn {
    _isSelectBtn = isSelectBtn;
    for (UIButton *b in _btnArr) {
        b.selected = NO;
    }
    UIButton * btn = [self viewWithTag:_isSelectBtn + 10];
    btn.selected = 1;
//    _selectView.centerX = btn.centerX;
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint p = self->_selectView.center;
        p.x = btn.centerX;
        self->_selectView.center = p;
    }];
}

-(instancetype)initWithSelect:(NSString *)titleText {
    if (self = [super init]) {
        kWEAKSELF(weakSelf);
        NSArray * titleArr = @[@"公用", @"私人"];
        
        MyLabel * title = [[MyLabel alloc] init];
        title.text = titleText;
        title.font = [SLFCommonTools pxFont:28];
        [self addSubview:title];
        self.titleLabel = title;
        CGSize size =[titleText sizeWithAttributes:@{NSFontAttributeName:title.font}];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.centerY.equalTo(weakSelf);
            make.size.mas_equalTo(CGSizeMake(size.width, size.height));
        }];
        
        UIView * view = [[UIView alloc] init];
        for (int i=0; i<2;i++) {
            UIButton * btn = [[UIButton alloc] init];
            btn.tag = i+10;
            [view addSubview:btn];
            
            btn.titleLabel.font = [SLFCommonTools pxFont:28];
            [btn setTitle:titleArr[i] forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor colorHex:@"333333"] forState:(UIControlStateNormal)];
            [btn setImage:[UIImage imageNamed:@"未选择"] forState:(UIControlStateNormal)];
            [btn setImage:[UIImage imageNamed:@"已选择"] forState:(UIControlStateSelected)];
            [btn addTarget:self action:@selector(selectClassClick:) forControlEvents:(UIControlEventTouchUpInside)];
            if (i == 0) {
                btn.selected = 1;
            }
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@((weakSelf.frame.size.width)/2));
                //.with.offset(CGRectGetWidth(weakSelf.frame)/2*i);
                if (i == 0) {
                    make.left.offset(0);
                    make.right.equalTo(view.mas_centerX);
                }else {
                    make.left.equalTo(view.mas_centerX);
                    make.right.equalTo(@(CGRectGetWidth(view.frame)));
                }
                make.top.and.bottom.equalTo(view).with.offset(0);
            }];
        }
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title.mas_right).with.offset(0);
            make.right.and.bottom.and.top.equalTo(weakSelf).with.offset(0);
        }];
    }
    return self;
}

-(instancetype)initWithSelectToPay:(NSString *)titleText {
    if (self = [super init]) {
        kWEAKSELF(weakSelf);
        
        MyLabel * title = [[MyLabel alloc] init];
        title.text = titleText;
        title.font = [SLFCommonTools pxFont:28];
        [self addSubview:title];
        self.titleLabel = title;
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.centerY.equalTo(weakSelf);
            make.size.mas_equalTo([SLFCommonTools textSize:title.text font:title.font]);
        }];
        
        UIButton * tempBtn;
        NSArray * titles = @[@"50元", @"100元", @"200元"];
        for (int i=0; i<titles.count;i++) {
            UIButton * btn = [[UIButton alloc] init];
            btn.tag = i+15;
            [self addSubview:btn];
            
            btn.titleLabel.font = [SLFCommonTools pxFont:28];
            [btn setTitle:titles[i] forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor colorHex:@"333333"] forState:(UIControlStateNormal)];
            btn.layer.borderColor = [UIColor colorHex:@"c9c9c9"].CGColor;
            btn.layer.borderWidth = 0.5;
            btn.layer.cornerRadius = 3;
            btn.layer.masksToBounds = 1;
            [btn addTarget:self action:@selector(selectPayClick:) forControlEvents:(UIControlEventTouchUpInside)];
            if (i == 0) {
                btn.selected = 1;
                [btn setBackgroundColor:[UIColor colorHex:@"52b448"]];
            }
            CGFloat w = (kScreenW - 60 - [SLFCommonTools textSize:title.text font:title.font].width)/3;
            switch (i) {
                case 0:
                    btn.sd_layout.leftSpaceToView(title, 10).centerYEqualToView(weakSelf).widthIs(w).heightIs(30);
                    break;
                case 1:
                    btn.sd_layout.leftSpaceToView(tempBtn, 10).centerYEqualToView(weakSelf).widthIs(w).heightIs(30);
                    break;
                case 2:
                    btn.sd_layout.leftSpaceToView(tempBtn, 10).centerYEqualToView(weakSelf).widthIs(w).heightIs(30);
                    break;
                    
                default:
                    break;
            }
            tempBtn = btn;
        }
    }
    return self;
}

-(void)selectPayClick:(UIButton *)btn {
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            [obj setBackgroundColor:[UIColor whiteColor]];
            [obj setTitleColor:[UIColor colorHex:@"333333"] forState:(UIControlStateNormal)];
        }
    }
    [btn setBackgroundColor:[UIColor colorHex:@"52b448"]];
    [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.isSelectBtn = btn.tag - 15;
    if (self.btnClickChange) {
        self.btnClickChange();
    }
}

-(void)setDeSelectBtn {
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            [obj setBackgroundColor:[UIColor whiteColor]];
            [obj setTitleColor:[UIColor colorHex:@"333333"] forState:(UIControlStateNormal)];
        }
    }
}

@end
