//
//  UILabel+Ext.m
//  HHMusic
//
//  Created by liumadu on 14-9-22.
//  Copyright (c) 2014年 hengheng. All rights reserved.
//

#import "UILabel+Ext.h"

@implementation UILabel (Ext)

- (CGFloat)contentWidth
{
  return [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}].width;
}

- (CGFloat)contentHeigh
{
  CGRect rect = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:self.font}
                                        context:nil];
  return rect.size.height;
}

- (void)setLableAdaptIOS10:(BOOL)lableAdaptIOS10{
    
    if (lableAdaptIOS10) {
        
//        if (IOS10_OR_LATER) {
           self.adjustsFontSizeToFitWidth = YES;
           self.adjustsFontForContentSizeCategory = YES;
            
//        }
    }
}

- (BOOL)lableAdaptIOS10{
    
//    if (IOS10_OR_LATER) {
        self.adjustsFontSizeToFitWidth = YES;
        self.adjustsFontForContentSizeCategory = YES;
//    }
    return  YES;
}

+ (UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    
    label.text = text;
    
    label.font = font;
    
    label.textColor = color;
    
    if (textAlignment) {
        label.textAlignment = textAlignment;
    }
    else {
        label.textAlignment = NSTextAlignmentLeft;
    }
    
    label.backgroundColor = [UIColor clearColor];
    
    return label;
}
+ (UILabel *)labelFrame:(CGRect)frame font:(UIFont *)font text:(NSString *)text color:(UIColor *)color
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    
    label.text = text ;
    
    label.font = font;
    
    label.textColor = color;
    
    label.backgroundColor = [UIColor clearColor];
    
    return label;
}
+ (CGFloat)calculateTextHeightWithFont:(UIFont *)font withContent:(NSString *)contentStr withWidth:(CGFloat)width
{
  CGRect rect = [contentStr boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:font}
                                         context:nil];
  return rect.size.height;
}

@end
