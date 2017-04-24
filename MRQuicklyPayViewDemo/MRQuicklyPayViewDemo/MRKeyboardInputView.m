//
//  MRQuicklyPayView.h
//  MRQuicklyPayViewDemo
//
//  Created by BloodSugar on 2017/4/21.
//  Copyright © 2017年 OFweek. All rights reserved.
//

#import "MRKeyboardInputView.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define KEYBOARDBTNWIDTH (SCREENWIDTH - 2) / 3.0
#define GETIMG(name) [UIImage imageNamed:name]
CGFloat const keyboardHeight = 216;
CGFloat const keyboardBtnHeight = (keyboardHeight - 4) / 4.0;

@interface MRKeyboardInputView ()

@end

@implementation MRKeyboardInputView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor  = [UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1];
        
        /**
         过滤视图中的子视图，保证视图的纯净性
         */
        for (UIView *vw in self.subviews) {
            [vw removeFromSuperview];
        }
        
        /**
         循环添加1-9的按钮
         */
        
        for (int i = 0; i < 9; i++) {
            NSInteger row  = i / 3;
            NSInteger colunm = i % 3;
            UIButton *numBtn = [[UIButton alloc]initWithFrame:CGRectMake(colunm * (KEYBOARDBTNWIDTH + 1), 1 + row*(keyboardBtnHeight+1), KEYBOARDBTNWIDTH, keyboardBtnHeight)];
            numBtn.tag = i + 1;
            [numBtn addTarget:self
                       action:@selector(pressNumBtn:)
             forControlEvents:UIControlEventTouchUpInside];
            NSString *imageNumStrNormal = [NSString stringWithFormat:@"%d.2",i+1];
            NSString *imageNumStrHight = [NSString stringWithFormat:@"%d.1",i+1];
            [numBtn setBackgroundImage:GETIMG(imageNumStrNormal) forState:UIControlStateNormal];
            [numBtn setBackgroundImage:GETIMG(imageNumStrHight) forState:UIControlStateHighlighted];
            numBtn.backgroundColor = [UIColor whiteColor];
            [self addSubview:numBtn];
        }
        
        /**
         添加0按钮以及删除按钮
         */
        UIButton *zeroBtn = [[UIButton alloc]initWithFrame:CGRectMake(KEYBOARDBTNWIDTH + 1, 1 + 3*(keyboardBtnHeight+1), KEYBOARDBTNWIDTH, keyboardBtnHeight)];
        zeroBtn.tag = 10;
        zeroBtn.backgroundColor = [UIColor whiteColor];
        NSString *imageNumStrNormal = [NSString stringWithFormat:@"%d.2",0];
        NSString *imageNumStrHight = [NSString stringWithFormat:@"%d.1",0];
        [zeroBtn setBackgroundImage:GETIMG(imageNumStrNormal) forState:UIControlStateNormal];
        [zeroBtn setBackgroundImage:GETIMG(imageNumStrHight) forState:UIControlStateHighlighted];
        [zeroBtn addTarget:self
                   action:@selector(pressNumBtn:)
         forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:zeroBtn];
        
        UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(2 * (KEYBOARDBTNWIDTH + 1), 1 + 3*(keyboardBtnHeight+1), KEYBOARDBTNWIDTH, keyboardBtnHeight)];
        deleteBtn.tag = 11;
        deleteBtn.backgroundColor = [UIColor whiteColor];
        [deleteBtn setBackgroundImage:GETIMG(@"delete_2") forState:UIControlStateNormal];
        [deleteBtn setBackgroundImage:GETIMG(@"delete_1") forState:UIControlStateHighlighted];
        [deleteBtn addTarget:self
                    action:@selector(pressNumBtn:)
          forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:deleteBtn];
        
        UIButton *emptyBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 1 + 3*(keyboardBtnHeight+1), KEYBOARDBTNWIDTH, keyboardBtnHeight)];
        emptyBtn.tag = 12;
        emptyBtn.backgroundColor = [UIColor whiteColor];
        [emptyBtn setBackgroundImage:GETIMG(@"empty_1") forState:UIControlStateNormal];
        emptyBtn.userInteractionEnabled = NO;
        [self addSubview:emptyBtn];
        
        CGRect rect = self.frame;
        rect.size.height = keyboardHeight;
        self.frame = rect;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor  = [UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1];
        
        /**
         过滤视图中的子视图，保证视图的纯净性
         */
        for (UIView *vw in self.subviews) {
            [vw removeFromSuperview];
        }
        
        /**
         循环添加1-9的按钮
         */
        for (int i = 0; i < 9; i++) {
            NSInteger row  = i / 3;
            NSInteger colunm = i % 3;
            UIButton *numBtn = [[UIButton alloc]initWithFrame:CGRectMake(colunm * (KEYBOARDBTNWIDTH + 1), 1 + row*(keyboardBtnHeight+1), KEYBOARDBTNWIDTH, keyboardBtnHeight)];
            numBtn.tag = i + 1;
            NSString *imageNumStrNormal = [NSString stringWithFormat:@"%d.2",i+1];
            NSString *imageNumStrHight = [NSString stringWithFormat:@"%d.1",i+1];
            [numBtn setBackgroundImage:GETIMG(imageNumStrNormal) forState:UIControlStateNormal];
            [numBtn setBackgroundImage:GETIMG(imageNumStrHight) forState:UIControlStateHighlighted];
            numBtn.backgroundColor = [UIColor whiteColor];
            [numBtn addTarget:self
                        action:@selector(pressNumBtn:)
              forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:numBtn];
        }
        
        /**
         添加0按钮以及删除按钮
         */
        UIButton *zeroBtn = [[UIButton alloc]initWithFrame:CGRectMake(KEYBOARDBTNWIDTH + 1, 1 + 3*(keyboardBtnHeight+1), KEYBOARDBTNWIDTH, keyboardBtnHeight)];
        zeroBtn.tag = 10;
        zeroBtn.backgroundColor = [UIColor whiteColor];
        NSString *imageNumStrNormal = [NSString stringWithFormat:@"%d.2",0];
        NSString *imageNumStrHight = [NSString stringWithFormat:@"%d.1",0];
        [zeroBtn setBackgroundImage:GETIMG(imageNumStrNormal) forState:UIControlStateNormal];
        [zeroBtn setBackgroundImage:GETIMG(imageNumStrHight) forState:UIControlStateHighlighted];
        [zeroBtn addTarget:self
                    action:@selector(pressNumBtn:)
          forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:zeroBtn];
        
        UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(2 * (KEYBOARDBTNWIDTH + 1), 1 + 3*(keyboardBtnHeight+1), KEYBOARDBTNWIDTH, keyboardBtnHeight)];
        deleteBtn.tag = 11;
        deleteBtn.backgroundColor = [UIColor whiteColor];
        [deleteBtn setBackgroundImage:GETIMG(@"delete_2") forState:UIControlStateNormal];
        [deleteBtn setBackgroundImage:GETIMG(@"delete_1") forState:UIControlStateHighlighted];
        [deleteBtn addTarget:self
                    action:@selector(pressNumBtn:)
          forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteBtn];
        
        UIButton *emptyBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 1 + 3*(keyboardBtnHeight+1), KEYBOARDBTNWIDTH, keyboardBtnHeight)];
        emptyBtn.tag = 12;
        emptyBtn.backgroundColor = [UIColor whiteColor];
        [emptyBtn setBackgroundImage:GETIMG(@"empty_1") forState:UIControlStateNormal];
        emptyBtn.userInteractionEnabled = NO;
        [self addSubview:emptyBtn];
        
        CGRect rect = self.frame;
        rect.size.height = keyboardHeight;
        self.frame = rect;

    }
    return self;
}

//点击按钮的监听事件
- (void)pressNumBtn:(UIButton *)btn{
//    代理传值
    if (_delegate && [_delegate respondsToSelector:@selector(pressWhichBtn:)]) {
        [_delegate pressWhichBtn:btn];
    }
}


@end
