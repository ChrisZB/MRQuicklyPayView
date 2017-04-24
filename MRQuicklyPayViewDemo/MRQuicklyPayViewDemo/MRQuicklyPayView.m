//
//  MRQuicklyPayView.m
//  MRQuicklyPayViewDemo
//
//  Created by BloodSugar on 2017/4/21.
//  Copyright © 2017年 OFweek. All rights reserved.
//

#import "MRQuicklyPayView.h"
#import "PwdTextField.h"
#import "MRKeyboardInputView.h"

#define kDefaultHeight 445
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define GETIMG(name) [UIImage imageNamed:name]
static NSString * const kAFViewShakerAnimationKey = @"kAFViewShakerAnimationKey";
static NSString * const kSamplePassword = @"333333";

@interface MRQuicklyPayView ()<UITextFieldDelegate,MRKeyboardPressWhichBtn>

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *titleLable;

@property (nonatomic, strong) PwdTextField *textField;

@property (nonatomic, strong) UILabel *tipLable;

@property (nonatomic, strong) UILabel *funcLable;

@property (nonatomic, strong) UIButton *forgetBtn;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UIButton *sureBtn;

//存放输入的数字
@property (nonatomic, strong) NSMutableArray *numArray;

//存放数字的view
@property (nonatomic, strong) UIView *numView;

@end

@implementation MRQuicklyPayView
{
    NSString *pwdStr;
    
    NSInteger showIndex;
    
    MRKeyboardInputView *inputView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        
        self.frame = [UIScreen mainScreen].bounds;
        
        //        //适应5
        //        CGFloat height = kHeight;
        //        if (kHeight<kDefaultHeight) {
        //            height = kDefaultHeight;
        //        }
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT-kDefaultHeight, SCREENWIDTH, kDefaultHeight)];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.alpha = 0.0;
        [self addSubview:_contentView];
        
        UIButton *pressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        pressBtn.frame = CGRectMake(0, 0, 40, 40);
        //        [closeBtn setBackgroundImage:GETIMG(@"btn_redpacket_close 2") forState:UIControlStateNormal];
        [pressBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:pressBtn];
        
        UIImageView *closeImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 16, 16)];
        closeImg.image = GETIMG(@"btn_redpacket_close 2");
        [pressBtn addSubview:closeImg];
        
        _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, SCREENWIDTH - 100, 18)];
        _titleLable.font = [UIFont systemFontOfSize:16];
        _titleLable.text = @"输入快捷支付密码";
        _titleLable.textColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        [_contentView addSubview:_titleLable];
        
        UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLable.frame)+10, SCREENWIDTH, 0.5)];
        topLine.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1];
        [_contentView addSubview:topLine];
        
        //输入支付密码的6个框
        showIndex = 0;
        _numArray = [NSMutableArray new];
        
        CGFloat inputWidth = (SCREENWIDTH-60)/6.0;
        
        _numView = [[UIView alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(topLine.frame)+20, SCREENWIDTH-60, inputWidth)];
        _numView.layer.cornerRadius = 5;
        _numView.layer.borderWidth = 0.5;
        _numView.layer.borderColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1].CGColor;
        [_contentView addSubview:_numView];
        for (int i = 0; i<6; i++)
        {
            UILabel *pwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(i*inputWidth, 0, inputWidth, inputWidth)];
            [_numView addSubview:pwdLabel];
            
            UIImageView *pointImg = [[UIImageView alloc] initWithFrame:CGRectMake((inputWidth-18)/2.0, (inputWidth-18)/2.0, 18, 18)];
            pointImg.image = GETIMG(@"image_point");
            pointImg.tag = 1000+i;
            [pwdLabel addSubview:pointImg];
            pointImg.hidden = YES;
            
            if (i!=5) {
                UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake((i+1)*inputWidth-0.5, 0, 0.5, inputWidth)];
                vLine.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1];
                [_numView addSubview:vLine];
            }
            
        }
        
        //用来支付啥的
        _funcLable = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_numView.frame)+15, SCREENWIDTH-15-15-65, 16)];
        _funcLable.textColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1];
        _funcLable.text = _payTitle;
        _funcLable.font = [UIFont systemFontOfSize:14];
        [_contentView addSubview:_funcLable];
        
        _forgetBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - 65 -15, CGRectGetMaxY(_numView.frame)+15, 65, 16)];
        [_forgetBtn setTitle:@"忘了密码?" forState:UIControlStateNormal];
        _forgetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_forgetBtn setTitleColor:[UIColor colorWithRed:66/255.0 green:139/255.0 blue:202/255.0 alpha:1] forState:UIControlStateNormal];
        [_forgetBtn addTarget:self action:@selector(forgetBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:_forgetBtn];
        
        //错误提示
        _tipLable = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_funcLable.frame)+15, SCREENWIDTH-30 , 16)];
        _tipLable.textColor = [UIColor redColor];
        _tipLable.font = [UIFont systemFontOfSize:14];
        [_contentView addSubview:_tipLable];
        
        /**
         这是自定义的键盘
         */
        inputView = [[MRKeyboardInputView alloc]initWithFrame:CGRectMake(0, kDefaultHeight - 216, SCREENWIDTH, 216)];
        inputView.delegate = self;
        [_contentView addSubview:inputView];
    }
    return self;
}

#pragma mark - 按钮的代理方法
- (void)pressWhichBtn:(UIButton *)numBtn{
    if (showIndex>=6) {
        return;
    }
    
    if (numBtn.tag == 11) {
        //这是删除
        NSLog(@"删除按钮");
        UIImageView *currentImageView = (UIImageView *)[_numView viewWithTag:(1000 + showIndex - 1)];
        currentImageView.hidden = YES;
        if (showIndex != 0) {
            showIndex--;
            [_numArray removeObjectAtIndex:showIndex];
        }else{
            showIndex = 0;
        }
        
        return;
    }
    UIImageView *currentImageView = (UIImageView *)[_numView viewWithTag:(1000 + showIndex)];
    currentImageView.hidden = NO;
    
    
    if (showIndex < 6) {
        showIndex++;
        if (numBtn.tag == 10) {
            [_numArray addObject:@(0)];
        }else {
            [_numArray addObject:@(numBtn.tag)];
        }
    }
    
    if (showIndex == 6) {
        //检查支付密码是否正确
        [self checkQuickPayPwd];
    }
}


//- (void)didChange:(UITextField *)textField{
//    /**
//     密码上限6位
//     */
//    if (textField.text.length > 6) {
//        textField.text = pwdStr;
//        return;
//    }
//    pwdStr = _textField.text;
//}

//视图出现的方法
- (void)show{
    [_textField becomeFirstResponder];
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    [window addSubview:self];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.65];
        _contentView.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@(0.8), @(1.05), @(1.1), @(1)];
    animation.keyTimes = @[@(0), @(0.3), @(0.5), @(1.0)];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    animation.duration = 0.3;
    [_contentView.layer addAnimation:animation forKey:@"bouce"];
}

//视图消失的方法
- (void)dismiss{
    [_textField resignFirstResponder];
    [UIView animateWithDuration:0.15 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
        _contentView.alpha = 0.0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 标题
- (void)setPayTitle:(NSString *)payTitle {
    _payTitle = payTitle;
    _funcLable.text = payTitle;
}

#pragma mark - 检测快捷支付密码是否正确
- (void)checkQuickPayPwd {
    pwdStr = [_numArray componentsJoinedByString:@""];
    
    //这里一般是通过请求判断输入的快捷密码是否正确
    if ([pwdStr isEqualToString:kSamplePassword]) {
        //正确
        [_textField resignFirstResponder];
        [self dismiss];
        if (_checkPwdBlock) {
            _checkPwdBlock(pwdStr);
        }
    }else {
        //不正确
        _tipLable.text = @"输入的密码不正确";
        [self addShakeAnimationForView:_contentView withDuration:0.5];
        showIndex = 0;
        [_numArray removeAllObjects];
        for (int i = 0; i<6; i++) {
            UIImageView *currentImageView = (UIImageView *)[_numView viewWithTag:(1000 + i)];
            currentImageView.hidden = YES;
        }

    }
}

#pragma mark - 忘记密码
- (void)forgetBtn:(UIButton *)btn{
    [_textField resignFirstResponder];
    [UIView animateWithDuration:0.15 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
        _contentView.alpha = 0.0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (_forgetPwdBlock) {
            _forgetPwdBlock();
        }
    }];
}

#pragma mark - Shake Animation
- (void)addShakeAnimationForView:(UIView *)view withDuration:(NSTimeInterval)duration {
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    CGFloat currentTx = view.transform.tx;
    
    animation.delegate = self;
    animation.duration = duration;
    animation.values = @[ @(currentTx), @(currentTx + 10), @(currentTx-8), @(currentTx + 8), @(currentTx -5), @(currentTx + 5), @(currentTx) ];
    animation.keyTimes = @[ @(0), @(0.225), @(0.425), @(0.6), @(0.75), @(0.875), @(1) ];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:animation forKey:kAFViewShakerAnimationKey];
}

@end
