//
//  UIImage+Ext.h
//  HHMusic
//
//  Created by liumadu on 14-10-2.
//  Copyright (c) 2014年 hengheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Ext)

+ (UIImage *)stretchableImage:(NSString *)imagePath left:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight;

/**
 *  加载图片
 *
 *  @param name 图片名
 */
+ (UIImage *)imageWithName:(NSString *)name;

/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

/**
 *  根据所给颜色创建一张100*128的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  根据所给颜色以及size创建一张图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  图片压缩
 */
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

@end
