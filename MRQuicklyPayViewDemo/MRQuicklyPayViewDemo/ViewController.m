//
//  ViewController.m
//  MRQuicklyPayViewDemo
//
//  Created by BloodSugar on 2017/4/21.
//  Copyright © 2017年 OFweek. All rights reserved.
//

#import "ViewController.h"
#import "MRQuicklyPayView.h"

#define kDefaultHeight 445
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    payBtn.backgroundColor = [UIColor orangeColor];
    payBtn.frame = CGRectMake(50, 100, 100, 100);
    [payBtn setTitle:@"验证支付密码" forState:UIControlStateNormal];
    [payBtn addTarget:self action:@selector(checkQuicklyPayPwd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payBtn];
}

- (void)checkQuicklyPayPwd {
    MRQuicklyPayView *alertView = [[MRQuicklyPayView alloc] init];
    alertView.payTitle = [NSString stringWithFormat:@"您需支付99999元"];
    [alertView show];
    alertView.checkPwdBlock = ^(NSString *pwd) {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码验证成功" preferredStyle:UIAlertControllerStyleAlert];
        [alertView addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alertView animated:YES completion:nil];
    };
    alertView.forgetPwdBlock = ^(){
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"跳转去找回密码" preferredStyle:UIAlertControllerStyleAlert];
        [alertView addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alertView animated:YES completion:nil];
    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
