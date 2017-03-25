//
//  TabBarBtn.m
//  WCFNetworking
//
//  Created by mac on 15/12/10.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "TabBarBtn.h"


// 文字的高度比例
#define kTitleRatio 0.25

@implementation TabBarBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 2.文字大小
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        //        self.imageEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
        // 3.图片的内容模式
        //            self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        // 4.设置选中时的背景
    }
    return self;
}
#pragma mark 覆盖父类在highlighted时的所有操作
- (void)setHighlighted:(BOOL)highlighted {
    //    [super setHighlighted:highlighted];
}

#pragma mark 调整内部ImageView的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = (contentRect.origin.x + contentRect.size.width-28)/2.0 ; //contentRect.origin.x+26;
    CGFloat imageY = (contentRect.origin.y + (1-kTitleRatio)*contentRect.size.height-28)/2.0 ; //contentRect.origin.y+5;
    CGFloat imageWidth = 28 ;//contentRect.size.height * (1- kTitleRatio )-10;
    CGFloat imageHeight = 28; // contentRect.size.height * (1- kTitleRatio )-11;
    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
}

#pragma mark 调整内部UILabel的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleHeight = contentRect.size.height * kTitleRatio;
    CGFloat titleY = contentRect.size.height - titleHeight - 3;
    CGFloat titleWidth = contentRect.size.width;
    return CGRectMake(titleX, titleY, titleWidth, titleHeight);
}

@end
