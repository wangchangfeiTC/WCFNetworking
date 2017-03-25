//
//  NSString+Additions.h
//  HHMusic
//
//  Created by liumadu on 14-9-22.
//  Copyright (c) 2014年 hengheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Ext)
// append query string to url
- (NSURL *)URLByAppendingQueryString:(NSString *)queryString;
// append query string to url
- (NSString *)URLStringByAppendingQueryString:(NSString *)queryString;
// 计算字符串的高度
- (float)heightForFont:(UIFont*)font width:(float)width lineBreakMode:(NSLineBreakMode)lineBreakMode;
/** 过滤字符 */
+ (NSString *)filterString:(NSString*)aString filterWith:(NSString*)fStr;
/** 判断是否为整形 */
- (BOOL)isPureInt;
/** 判断是否为浮点形 */
- (BOOL)isPureFloat;
/** 判断是否是手机号 */
- (BOOL)isMobile;
- (CGSize)sizeWithFont:(UIFont *)font;
- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;



- (BOOL)isNotEmpty;

- (NSString *)trimWhitespaceAndNewline;

- (BOOL)containsCharacterSet:(NSCharacterSet *)set;

- (BOOL)containsString:(NSString *)string;

- (int)wordsCount;

- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;

- (NSURL *)URL;
- (NSURL *)fileURL;

- (NSString *)MD5String;

- (BOOL)isNumber;
- (BOOL)isEnglishWords;
- (BOOL)isChineseWords;

- (BOOL)isEmail;
- (BOOL)isURL;
- (BOOL)isPhoneNumber;
- (BOOL)isMobilePhoneNumber;
- (BOOL)isIdentifyCardNumber;
- (BOOL)isOrganizationCode;

- (BOOL)isValidPassword;
- (BOOL)isValidName;

- (NSDate *)dateWithFormat:(NSString *)format;

- (NSDictionary *)paramValue;

- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
- (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

- (CGSize)sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
- (CGSize)sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

@end
