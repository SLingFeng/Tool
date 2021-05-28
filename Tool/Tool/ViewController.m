//
//  ViewController.m
//  Tool
//
//  Created by mac on 2021/4/9.
//

#import "ViewController.h"
#import "UIButton+LF.h"
#import "LFTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 150, 40, 40)];
    btn.backgroundColor = UIColor.redColor;
    [self.view addSubview:btn];
    btn.onClickBlock = ^(UIButton * _Nonnull btn) {
        NSLog(@"qwe");
    };
    
    [LFTool getDivceSize];

}


@end
