//
//  MRQuicklyPayView.h
//  MRQuicklyPayViewDemo
//
//  Created by BloodSugar on 2017/4/21.
//  Copyright © 2017年 OFweek. All rights reserved.
//

#import "PwdTextField.h"

@implementation PwdTextField

- (void)drawPlaceholderInRect:(CGRect)rect
{
    CGRect frame = rect;
    frame.origin.y = (self.bounds.size.height - 15) / 2.0;
    [[self placeholder] drawInRect:frame
                    withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1],NSForegroundColorAttributeName,nil]];
}
@end
