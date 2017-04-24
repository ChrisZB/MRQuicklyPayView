//
//  MRQuicklyPayView.h
//  MRQuicklyPayViewDemo
//
//  Created by BloodSugar on 2017/4/21.
//  Copyright © 2017年 OFweek. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CheckPwdSuccessBlock)(NSString *);

typedef void(^ForgetPwdBlock)();

@interface MRQuicklyPayView : UIView

@property (nonatomic, copy) NSString *payTitle;

//验证密码成功回调
@property (nonatomic, copy) CheckPwdSuccessBlock checkPwdBlock;

@property (nonatomic, copy) ForgetPwdBlock forgetPwdBlock;

- (void)show;

- (void)dismiss;

@end
