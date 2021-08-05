//
//  ViewController.m
//  Tool
//
//  Created by mac on 2021/4/9.
//

#import "ViewController.h"
#import "UIButton+LF.h"
#import "LFTool.h"
#import "Tool-Swift.h"

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
        SWViewController *vc = [[SWViewController alloc] init];
        [self.navigationController pushViewController:vc animated:1];
    };
    
    [LFTool getDivceFreeAndTotalSize];

}


@end
