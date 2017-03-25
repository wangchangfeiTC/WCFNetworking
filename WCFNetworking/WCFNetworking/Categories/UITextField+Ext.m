//
//  UITextField+Ext.m
//  EFHealth
//
//  Created by 舒鹏 on 15/12/17.
//  Copyright © 2015年 ef. All rights reserved.
//

#import "UITextField+Ext.h"
#import <objc/runtime.h>

static NSString *myLegth = @"myLegth";

@implementation UITextField (Ext)

- (void)setTheLength:(NSString *)theLength{
    
    objc_setAssociatedObject(self, (__bridge const void *)(myLegth), theLength, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

- (NSString *)theLength{
    return objc_getAssociatedObject(self, (__bridge const void *)(myLegth));
}

- (void)limitTheLength:(int )theLength{
    
    myLegth = [NSString stringWithFormat:@"%d",theLength];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
//                                                name:@"UITextFieldTextDidChangeNotification"
//                                              object:self];
    
}

- (void)textFiledEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    
    NSString *toBeString = textField.text;
    NSString *lang = textField.textInputMode.primaryLanguage ; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > [myLegth intValue]) {
                textField.text = [toBeString substringToIndex:[myLegth intValue]];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > [myLegth intValue]) {
            textField.text = [toBeString substringToIndex:[myLegth intValue]];
        }
        
    }
}
//-(void)dealloc{
//    [[NSNotificationCenter defaultCenter]removeObserver:self
//                                                   name:@"UITextFieldTextDidChangeNotification"
//                                                 object:self];
//}
@end



@implementation UITextView (Ext)

- (void)setTheLength:(NSString *)theLength{
    
    objc_setAssociatedObject(self, (__bridge const void *)(myLegth), theLength, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

- (NSString *)theLength{
    return objc_getAssociatedObject(self, (__bridge const void *)(myLegth));
}

- (void)limitTheLength:(int )theLength{
//    
//    myLegth = [NSString stringWithFormat:@"%d",theLength];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewEditChanged:)
//                                                name:@"UITextViewTextDidChangeNotification"
//                                              object:self];
    
}

- (void)textViewEditChanged:(NSNotification *)obj{
    UITextView *textView = (UITextView *)obj.object;
    
    NSString *toBeString = textView.text;
    NSString *lang = textView.textInputMode.primaryLanguage ; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > [myLegth intValue]) {
                textView.text = [toBeString substringToIndex:[myLegth intValue]];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > [myLegth intValue]) {
            textView.text = [toBeString substringToIndex:[myLegth intValue]];
        }
        
    }
}
//-(void)dealloc{
//    [[NSNotificationCenter defaultCenter]removeObserver:self
//                                                   name:@"UITextViewTextDidChangeNotification"
//                                                 object:self];
//}

@end
