//
//  UIImage+Ext.m
//  HHMusic
//
//  Created by liumadu on 14-10-2.
//  Copyright (c) 2014年 hengheng. All rights reserved.
//

#import "UIImage+Ext.h"

@implementation UIImage (Ext)

+ (UIImage *)stretchableImage:(NSString *)imagePath left:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight
{
  return [[UIImage imageNamed:imagePath] stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
}

+ (UIImage *)imageWithName:(NSString *)name
{
    NSString *newName = [name stringByAppendingString:@"_os7"];
    UIImage *image = [UIImage imageNamed:newName];
    if (image == nil) { // 没有_os7后缀的图片
        image = [UIImage imageNamed:name];
    }
    return image;
}

+ (UIImage *)resizedImageWithName:(NSString *)name
{
    return [self resizedImageWithName:name left:0.5 top:0.5];
}

+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [self imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGFloat imageW = 100;
    CGFloat imageH = 128;
    CGSize size = CGSizeMake(imageW, imageH);
    UIImage *image = [self imageWithColor:color size:size];
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGFloat imageW = size.width;
    CGFloat imageH = size.height;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW, imageH), NO, 0.0);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageW, imageH));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//对图片尺寸进行压缩--
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    newSize = [self scaleWithImage:image size:newSize];
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    if (!newImage) {
        NSLog(@"UIImage+Ext 压缩失败！");
        return image;
    }
    
    // Return the new image.
    return newImage;
}

+ (CGSize)scaleWithImage:(UIImage *)image size:(CGSize)size {
    CGSize imageSize = image.size;
    if (imageSize.width > imageSize.height) {
        size.height = image.size.height * (size.width / imageSize.width);
        
    } else {
        size.width = imageSize.width * (size.height / imageSize.height);
    }
    return size;
}
@end
