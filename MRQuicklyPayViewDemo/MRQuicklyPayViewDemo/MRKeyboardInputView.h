//
//  MRQuicklyPayView.h
//  MRQuicklyPayViewDemo
//
//  Created by BloodSugar on 2017/4/21.
//  Copyright © 2017年 OFweek. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol MRKeyboardPressWhichBtn <NSObject>

@required

- (void)pressWhichBtn:(UIButton *)numBtn;

@end

@interface MRKeyboardInputView : UIView

//设置代理属性
@property (nonatomic,assign) id<MRKeyboardPressWhichBtn> delegate;

@end
