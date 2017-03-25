//
//  UILabel+Ext.h
//  HHMusic
//
//  Created by liumadu on 14-9-22.
//  Copyright (c) 2014年 hengheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Ext)

@property(nonatomic, readonly) CGFloat contentWidth;
@property(nonatomic, readonly) CGFloat contentHeigh;
@property(nonatomic, assign) BOOL lableAdaptIOS10;

+ (UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color  textAlignment:(NSTextAlignment)textAlignment;
+ (CGFloat)calculateTextHeightWithFont:(UIFont *)font withContent:(NSString *)contentStr withWidth:(CGFloat)width;

@end
