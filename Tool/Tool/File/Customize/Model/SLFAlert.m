//
//  SLFAlert.m
//
//  Copyright © 2017年 孙凌锋. All rights reserved.
//

#import "SLFAlert.h"
#import <Masonry/Masonry.h>
#import "UIButton+LF.h"

#define kWEAKSELF(weakSelf) __weak __typeof(&*self) weakSelf = self
#define kWEAKOBJ(weakObj, _obj) __weak __typeof(&*_obj) weakObj = _obj
#define kMainSpace 0

#define SLFALAERTLEFTTEXTCOLOR [UIColor colorWithString:@"#1384FF"]
#define SLFALAERTRIGHTTEXTCOLOR [UIColor colorWithString:@"#1384FF"]

@interface SLFAlert ()
{
    UIView *_backgroundView;
    UIView *_alertView;
}
@end

@implementation SLFAlert

static SLFAlert * instance = nil;
+(SLFAlert *)shareSLFAlert
{
    if (!instance) {
        instance = [[SLFAlert alloc]init];
    }
    return instance;
}
+(SLFAlert *)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onece;
    dispatch_once(&onece, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}


//只有确定
+ (void)showSystemAlertWithTitle:(NSString *)title text:(NSString *)text determineTitle:(NSString *)determine alertClick:(alertClick)alertClick {
    [SLFAlert showSystemAlertWithVC:nil title:title text:text determineTitle:determine cancelTitle:nil cancel:0 alertClick:alertClick];
}

+ (void)showSystemAlertWithTitle:(NSString *)title text:(NSString *)text determineTitle:(NSString *)determine cancelTitle:(NSString *)cancelTitle alertClick:(alertClick)alertClick {
    [SLFAlert showSystemAlertWithVC:nil title:title text:text determineTitle:determine cancelTitle:cancelTitle cancel:1 alertClick:alertClick];
}

+(void)showSystemAlertWithVC:(UIViewController *)weakSelf title:(NSString *)title text:(NSString *)text determineTitle:(NSString *)determine cancelTitle:(NSString *)cancelTitle alertClick:(alertClick)alertClick {
    [SLFAlert showSystemAlertWithVC:nil title:title text:text determineTitle:determine cancelTitle:cancelTitle cancel:1 alertClick:alertClick];
}

+(void)showSystemAlertWithVC:(UIViewController *)weakSelf title:(NSString *)title text:(NSString *)text determineTitle:(NSString *)determine cancelTitle:(NSString *)cancelTitle cancel:(BOOL)cancel alertClick:(alertClick)alertClick {
    {
        UIViewController *vc = weakSelf==nil?[SLFAlert currentViewController]:weakSelf;
        
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:text preferredStyle:(UIAlertControllerStyleAlert)];
        
        if (cancel) {
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
                if (alertClick) {
                    alertClick(0);
                }
            }];
            
            [alertController addAction:cancelAction];
        }
        
        UIAlertAction * queRen = [UIAlertAction actionWithTitle:determine style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
            if (alertClick) {
                alertClick(1);
            }
        }];
        [alertController addAction:queRen];
        
        [vc presentViewController:alertController animated:YES completion:nil];
    }
}

//sheet
+(void)showSystemActionSheetWithTitle:(NSString *)title text:(NSString *)text determineTitle:(NSString *)determine cancelTitle:(NSString *)cancelTitle cancel:(BOOL)cancel alertClick:(alertClick)alertClick {
    [SLFAlert showSystemActionSheetWithVC:nil title:title text:text determineTitle:determine cancelTitle:cancelTitle cancel:cancel alertClick:alertClick];
}

+(void)showSystemActionSheetWithVC:(UIViewController *)weakSelf title:(NSString *)title text:(NSString *)text determineTitle:(NSString *)determine cancelTitle:(NSString *)cancelTitle cancel:(BOOL)cancel alertClick:(alertClick)alertClick {
    
    UIViewController *vc = weakSelf==nil?[SLFAlert currentViewController]:weakSelf;
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:text preferredStyle:(UIAlertControllerStyleActionSheet)];
    if (cancel) {
        [alertController addAction:[UIAlertAction actionWithTitle:cancelTitle style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            if (alertClick) {
                alertClick(0);
            }
        }]];
    }
    UIAlertAction * queRen = [UIAlertAction actionWithTitle:determine style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        
        if (alertClick) {
            alertClick(1);
        }
    }];
    [alertController addAction:queRen];
    
    [vc presentViewController:alertController animated:YES completion:nil];
}


+(void)showSystemActionSheetWithTitle:(NSString *)title text:(NSString *)text cancelText:(NSString *)cancelText textArr:(NSArray<NSString *> *)textArr alertClickIndex:(alertClickIndex)alertClickIndex {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:text preferredStyle:(UIAlertControllerStyleActionSheet)];
    for (int i=0; i<textArr.count; i++) {
        NSString * str = textArr[i];
        [alertController addAction:[UIAlertAction actionWithTitle:str style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            if (alertClickIndex) {
                alertClickIndex(i+1);
            }
        }]];
    }
    
    [alertController addAction:[UIAlertAction actionWithTitle:cancelText style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        if (alertClickIndex) {
            alertClickIndex(0);
        }
    }]];

    [[SLFAlert currentViewController] presentViewController:alertController animated:YES completion:nil];
}

+(void)setupTextFont:(NSString *)title text:(NSString *)text ac:(UIAlertController *)alertController {
    //    NSDictionary * style = @{@"font" : [SLFCommonTools pxFont:28],
    //                             @"font2" : [SLFCommonTools pxFont:20],
    //                             @"color" : k666666,
    //                             @"color2" : k999999};
    //title
    //    if (nil != title) {
    //        NSMutableAttributedString *alertTitleStr = [[NSMutableAttributedString alloc] initWithString:title];
    //        [alertTitleStr addAttribute:NSFontAttributeName value:[SLFCommonTools pxFont:32] range:NSMakeRange(0, title.length)];
    //        [alertTitleStr addAttribute:NSForegroundColorAttributeName value:k111111 range:NSMakeRange(0, title.length)];
    //        [alertController setValue:alertTitleStr forKey:@"attributedTitle"];
    //    }
    //
    //    //message
    //    if (nil != text) {
    //        NSMutableAttributedString *alertMessageStr = [[NSMutableAttributedString alloc] initWithString:text];
    //        [alertMessageStr addAttribute:NSFontAttributeName value:[SLFCommonTools pxFont:32] range:NSMakeRange(0, text.length)];
    //        [alertMessageStr addAttribute:NSForegroundColorAttributeName value:k666666 range:NSMakeRange(0, title.length)];
    //        [alertController setValue:alertMessageStr forKey:@"attributedMessage"];
    //    }
}

+ (void)alertTextFView:(UIViewController *)ws title:(NSString *)title text:(NSString *)text determineTitle:(NSString *)determine cancelTitle:(NSString *)cancelTitle placeholder:(NSString *)placeholder alertClick:(alertClickText)alertClick {
    if (ws == nil) {
        ws = [SLFAlert currentViewController];
    }
    [SLFAlert shareSLFAlert].text = nil;
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:text preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter]removeObserver:[SLFAlert shareSLFAlert] name:UITextFieldTextDidChangeNotification object:nil];
    }];
    
    [alertController addAction:cancelAction];
    
    UIAlertAction * queRen = [UIAlertAction actionWithTitle:determine style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter]removeObserver:[SLFAlert shareSLFAlert] name:UITextFieldTextDidChangeNotification object:nil];
        
        if (alertClick) {
            alertClick([SLFAlert shareSLFAlert].text);
        }
    }];
    [alertController addAction:queRen];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = placeholder;
        [[NSNotificationCenter defaultCenter]addObserver:[SLFAlert shareSLFAlert] selector:@selector(handleTextFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    }];
    [SLFAlert shareSLFAlert].alertC = alertController;
    [ws presentViewController:alertController animated:YES completion:nil];
}

- (void)handleTextFieldDidChanged:(NSNotification *)notification {
    if ([SLFAlert shareSLFAlert].alertC) {
        UITextField *textField = [SLFAlert shareSLFAlert].alertC.textFields.firstObject;
        UIAlertAction *action  = [SLFAlert shareSLFAlert].alertC.actions.lastObject;
        action.enabled = textField.text.length > 0;
        [SLFAlert shareSLFAlert].text = textField.text;
    }
}

#pragma mark - 自定义alert
//
+ (instancetype)showAlertWithTitle:(NSString *)title checkTitle:(NSString *)checkTitle block:(alertClickIndex)block {
    return [[SLFAlert alloc] initWithTitle:title leftTitle:nil rightTitle:checkTitle change:NO block:block];
}

+ (instancetype)showAlertWithTitle:(NSString *)title leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle block:(alertClickIndex)block {
    return [[SLFAlert alloc] initWithTitle:title leftTitle:leftTitle rightTitle:rightTitle change:NO block:block];
}

+ (instancetype)showAlertWithTitle:(NSString *)title leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle change:(BOOL)change block:(alertClickIndex)block {
    return [[SLFAlert alloc] initWithTitle:title leftTitle:leftTitle rightTitle:rightTitle change:change block:block];
}

- (instancetype)initWithTitle:(NSString *)title leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle change:(BOOL)change block:(alertClickIndex)block {
    if (self = [super init]) {

        _backgroundView = [[UIView alloc] initWithFrame:([UIScreen mainScreen].bounds)];
        [[UIApplication sharedApplication].keyWindow addSubview:_backgroundView];

        UIView * b = [[UIView alloc] initWithFrame:([UIScreen mainScreen].bounds)];
        b.backgroundColor = [[UIColor colorWithString:@"#000000"] colorWithAlphaComponent:0.6];
        [_backgroundView addSubview:b];

        _alertView = [[UIView alloc] init];
        [_backgroundView addSubview:_alertView];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.masksToBounds = 1;
        _alertView.layer.cornerRadius = 15;

        UIView *line = [SLFAlert lineViewToHight:0.5 spaceForRightAndLetf:0];
        [_alertView addSubview:line];

        kWEAKOBJ(weakAlert, _alertView);
        kWEAKSELF(weakSelf);

        UILabel * titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = k111111;
        titleLabel.numberOfLines = 0;
        [titleLabel setText:title];
//        titleLabel.font = [UIFont systemFontOfSize:17];
        [_alertView addSubview:titleLabel];
        titleLabel.textAlignment = NSTextAlignmentCenter;


        UIButton * rightBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_alertView addSubview:rightBtn];
        [rightBtn setTitle:rightTitle forState:(UIControlStateNormal)];
        [rightBtn setTitleColor:change?k666666:SLFALAERTRIGHTTEXTCOLOR forState:(UIControlStateNormal)];
//        rightBtn.titleLabel.font = [UIFont systemFontOfSize:17];

        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(24);
            make.left.and.right.offset(0);
            make.centerX.equalTo(weakAlert);
        }];

        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(132, 46));
            make.right.offset(0);
            make.top.equalTo(titleLabel.mas_bottom).offset(24);
        }];

        if (leftTitle != nil) {
            
            UIView *lineDash = [SLFAlert lineViewToHight:0.5 spaceForRightAndLetf:0];
            [_alertView addSubview:lineDash];
            
            UIButton * leftBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
            [_alertView addSubview:leftBtn];
            [leftBtn setTitle:leftTitle forState:(UIControlStateNormal)];
            [leftBtn setTitleColor:change?kFF0000:SLFALAERTLEFTTEXTCOLOR forState:(UIControlStateNormal)];
//            leftBtn.titleLabel.font = [SLFCommonTools pxFont:32];

            [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(132, 46));
                make.left.offset(0);
                make.centerY.equalTo(rightBtn);
            }];

            [leftBtn setOnClickBlock:^(UIButton *sender) {
                [weakSelf cancelTap];
                if (block) {
                    block(0);
                }
            }];
            
            [lineDash mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakAlert);
                make.centerY.equalTo(leftBtn);
                make.size.mas_equalTo(CGSizeMake(1, 46));
            }];
        }else {
            [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(46);
                make.left.and.right.offset(0);
            }];
        }

        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(kMainSpace);
            make.right.offset(-kMainSpace);
            make.height.mas_equalTo(1);
            make.bottom.equalTo(rightBtn.mas_top);
        }];

        [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_backgroundView);
            make.width.mas_equalTo(270);
            make.top.equalTo(titleLabel.mas_top);
            make.bottom.equalTo(rightBtn.mas_bottom);
        }];


//        [_alertView setupAutoHeightWithBottomView:rightBtn bottomMargin:0];
        
//        CGRect rect = _alertView.frame;
//        rect.size.height = rightBtn.frame.size.height;
//        _alertView.frame = rect;

        [rightBtn setOnClickBlock:^(UIButton *sender) {
            [weakSelf cancelTap];
            if (block) {
                block(1);
            }
        }];

//        [self show];
    }
    return self;
}
#pragma mark - 副标题

+ (instancetype)showAlertWithTitle:(NSString *)title subTitle:(NSString *)subTitle leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle change:(BOOL)change block:(alertClickIndex)block {
    return [[SLFAlert shareSLFAlert] initWithTitle:title subTitle:subTitle leftTitle:leftTitle rightTitle:rightTitle change:change block:block];
}

- (instancetype)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle change:(BOOL)change block:(alertClickIndex)block {
    if (self = [super init]) {
        
        _backgroundView = [[UIView alloc] initWithFrame:kScreen];
        [[UIApplication sharedApplication].keyWindow addSubview:_backgroundView];
        
        UIView * b = [[UIView alloc] initWithFrame:kScreen];
        b.backgroundColor = [[UIColor colorWithString:@"#000000"] colorWithAlphaComponent:0.6];
        [_backgroundView addSubview:b];
        
        _alertView = [[UIView alloc] init];
        [_backgroundView addSubview:_alertView];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.masksToBounds = 1;
        _alertView.layer.cornerRadius = 15;
        
        UIView *line = [SLFAlert lineViewToHight:0.5 spaceForRightAndLetf:0];
        [_alertView addSubview:line];
        
        kWEAKOBJ(weakAlert, _alertView);
        kWEAKSELF(weakSelf);
        
        UILabel * titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = k111111;
        titleLabel.numberOfLines = 0;
        [titleLabel setText:title];
//        titleLabel.font = [UIFont systemFontOfSize:17];
        [_alertView addSubview:titleLabel];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        UILabel * subTitleLabel = [[UILabel alloc] init];
        subTitleLabel.textColor = k666666;
        subTitleLabel.numberOfLines = 0;
        [subTitleLabel setText:title];
        subTitleLabel.font = [UIFont systemFontOfSize:16];
        [_alertView addSubview:subTitleLabel];
        subTitleLabel.textAlignment = NSTextAlignmentCenter;
//        MyLabel *subTitleLabel = [[MyLabel alloc] initWithFontSize:28 fontColor:k666666 setText:subTitle];
//        [_alertView addSubview:subTitleLabel];
//        subTitleLabel.textAlignment = NSTextAlignmentCenter;
        
        UIButton * rightBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_alertView addSubview:rightBtn];
        [rightBtn setTitle:rightTitle forState:(UIControlStateNormal)];
        [rightBtn setTitleColor:change?k666666:SLFALAERTRIGHTTEXTCOLOR forState:(UIControlStateNormal)];
//        rightBtn.titleLabel.font = [SLFCommonTools pxFont:32];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(24);
            make.left.and.right.offset(0);
            make.centerX.equalTo(weakAlert);
        }];
        
        [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(kMainSpace);
            make.right.offset(-kMainSpace);
            make.top.equalTo(titleLabel.mas_bottom).offset(0);
        }];
        
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(132, 46));
            make.right.offset(0);
            make.top.equalTo(subTitleLabel.mas_bottom).offset(24);
        }];
        
        if (leftTitle != nil) {
            
            UIView *lineDash = [SLFAlert lineViewToHight:0.5 spaceForRightAndLetf:0];
            [_alertView addSubview:lineDash];
            
            UIButton * leftBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
            [_alertView addSubview:leftBtn];
            [leftBtn setTitle:leftTitle forState:(UIControlStateNormal)];
            [leftBtn setTitleColor:change?kFF0000:SLFALAERTLEFTTEXTCOLOR forState:(UIControlStateNormal)];
//            leftBtn.titleLabel.font = [SLFCommonTools pxFont:32];
            
            [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(132, 46));
                make.left.offset(0);
                make.centerY.equalTo(rightBtn);
            }];
            
            [leftBtn setOnClickBlock:^(UIButton *sender) {
                [weakSelf cancelTap];
                if (block) {
                    block(0);
                }
            }];
            
            [lineDash mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakAlert);
                make.centerY.equalTo(leftBtn);
                make.size.mas_equalTo(CGSizeMake(1, 30));
            }];
        }else {
            [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(46);
                make.left.and.right.offset(0);
            }];
        }
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(kMainSpace);
            make.right.offset(-kMainSpace);
            make.height.mas_equalTo(1);
            make.bottom.equalTo(rightBtn.mas_top);
        }];
        
        [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_backgroundView);
            make.width.mas_equalTo(264);
            make.top.equalTo(titleLabel.mas_top);
            make.bottom.equalTo(rightBtn.mas_bottom);
        }];
        
        
//        [_alertView setupAutoHeightWithBottomView:rightBtn bottomMargin:0];
        
        [rightBtn setOnClickBlock:^(UIButton *sender) {
            [weakSelf cancelTap];
            if (block) {
                block(1);
            }
        }];
    }
    return self;
}
#pragma mark - 图片
+ (instancetype)showAlertWithTitle:(NSString *)title subTitle:(NSString *)subTitle imageName:(NSString *)imageName leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle change:(BOOL)change block:(alertClickIndex)block {
    return [[SLFAlert shareSLFAlert] initWithTitle:title subTitle:subTitle imageName:imageName leftTitle:leftTitle rightTitle:rightTitle change:change block:block];
}

- (instancetype)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle imageName:(NSString *)imageName leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle change:(BOOL)change block:(alertClickIndex)block {
    if (self = [super init]) {
        
        _backgroundView = [[UIView alloc] initWithFrame:kScreen];
        [[UIApplication sharedApplication].keyWindow addSubview:_backgroundView];
        
        UIView * b = [[UIView alloc] initWithFrame:kScreen];
        b.backgroundColor = [[UIColor colorWithString:@"#000000"] colorWithAlphaComponent:0.6];
        [_backgroundView addSubview:b];
        
        _alertView = [[UIView alloc] init];
        [_backgroundView addSubview:_alertView];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.masksToBounds = 1;
        _alertView.layer.cornerRadius = 15;
        
        UIView *line = [SLFAlert lineViewToHight:0.5 spaceForRightAndLetf:0];
        [_alertView addSubview:line];
        
        kWEAKOBJ(weakAlert, _alertView);
        kWEAKSELF(weakSelf);
        
//        MyLabel * titleLabel = [[MyLabel alloc] initWithFontSize:32 fontColor:k111111 setText:title];
//        titleLabel.font = [SLFCommonTools pxFont:32];
//        [_alertView addSubview:titleLabel];
//
//        MyLabel *subTitleLabel = [[MyLabel alloc] initWithFontSize:28 fontColor:k666666 setText:subTitle];
//        [_alertView addSubview:subTitleLabel];
        UILabel * titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = k111111;
        titleLabel.numberOfLines = 0;
        [titleLabel setText:title];
//        titleLabel.font = [UIFont systemFontOfSize:17];
        [_alertView addSubview:titleLabel];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        UILabel * subTitleLabel = [[UILabel alloc] init];
        subTitleLabel.textColor = k666666;
        subTitleLabel.numberOfLines = 0;
        [subTitleLabel setText:title];
        subTitleLabel.font = [UIFont systemFontOfSize:16];
        [_alertView addSubview:subTitleLabel];
        subTitleLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        [_alertView addSubview:imageView];
        
        UIButton * rightBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_alertView addSubview:rightBtn];
        [rightBtn setTitle:rightTitle forState:(UIControlStateNormal)];
        [rightBtn setTitleColor:change?k666666:SLFALAERTRIGHTTEXTCOLOR forState:(UIControlStateNormal)];
//        rightBtn.titleLabel.font = [SLFCommonTools pxFont:32];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(kMainSpace);
            make.size.mas_equalTo(CGSizeMake(95/2, 95/2));
            make.top.offset(30);
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(30);
            make.right.offset(0);
            make.left.equalTo(imageView.mas_right).offset(10);
        }];
        
        [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(imageView.mas_bottom);
            make.right.offset(0);
            make.left.equalTo(imageView.mas_right).offset(10);
        }];
        
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(132, 46));
            make.right.offset(0);
            make.top.equalTo(subTitleLabel.mas_bottom).offset(24);
        }];
        
        if (leftTitle != nil) {
            
            UIView *lineDash = [SLFAlert lineViewToHight:0.5 spaceForRightAndLetf:0];
            [_alertView addSubview:lineDash];
            
            UIButton * leftBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
            [_alertView addSubview:leftBtn];
            [leftBtn setTitle:leftTitle forState:(UIControlStateNormal)];
            [leftBtn setTitleColor:change?kFF0000:SLFALAERTLEFTTEXTCOLOR forState:(UIControlStateNormal)];
//            leftBtn.titleLabel.font = [SLFCommonTools pxFont:32];
            
            [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(132, 46));
                make.left.offset(0);
                make.centerY.equalTo(rightBtn);
            }];
            
            [leftBtn setOnClickBlock:^(UIButton *sender) {
                [weakSelf cancelTap];
                if (block) {
                    block(0);
                }
            }];
            
            [lineDash mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakAlert);
                make.centerY.equalTo(leftBtn);
                make.size.mas_equalTo(CGSizeMake(1, 30));
            }];
        }else {
            [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(46);
                make.left.and.right.offset(0);
            }];
        }
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(kMainSpace);
            make.right.offset(-kMainSpace);
            make.height.mas_equalTo(1);
            make.bottom.equalTo(rightBtn.mas_top);
        }];
        
        [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_backgroundView);
            make.width.mas_equalTo(264);
            make.top.equalTo(titleLabel.mas_top);
            make.bottom.equalTo(rightBtn.mas_bottom);
        }];
        
        
//        [_alertView setupAutoHeightWithBottomView:rightBtn bottomMargin:0];
        
        [rightBtn setOnClickBlock:^(UIButton *sender) {
            [weakSelf cancelTap];
            if (block) {
                block(1);
            }
        }];
    }
    return self;
}


-(void)show {
    kWEAKOBJ(weakOBJ, _backgroundView);
    [UIView animateWithDuration:0.35 animations:^{
        weakOBJ.alpha = 1;
    }];
}

-(void)cancelTap {
    kWEAKOBJ(weakOBJ, _backgroundView);
//    [UIView animateWithDuration:0.35 animations:^{
//        weakOBJ.alpha = 0;
//    } completion:^(BOOL finished) {
        [weakOBJ removeFromSuperview];
//    }];
}

+ (UIViewController*)currentViewController {
 
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
 
    while (1) {
    
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    
    }
 
    return vc;
 
}

+(UIView *)lineViewToHight:(float)hight spaceForRightAndLetf:(float)space {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(space, hight, kScreenW - space*2, 0.5)];
    view.backgroundColor = [UIColor colorWithString:@"#D7D5D6"];
    return view;
}

@end
