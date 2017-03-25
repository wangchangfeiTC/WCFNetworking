//
//  TabBar.m
//  WCFNetworking
//
//  Created by mac on 15/12/10.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "TabBar.h"


#import "TabBarBtn.h"

@interface TabBar()
{
    TabBarBtn *_selectBtn ;
}
@end

@implementation TabBar

- (void)addTabBarButton:(NSString *)icon selIcon:(NSString *)selIcon title:(NSString *)title index:(int)index
{
    TabBarBtn *btn = [[TabBarBtn alloc]init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selIcon] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTag:index];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self addSubview:btn];
    [self adjustButtonFrames];
    
    // 默认选中第0个按钮
    if (self.subviews.count == 1)  [self btnClick:btn];
    
}

- (void)adjustButtonFrames
{
    long btnCount = self.subviews.count;
    for (int i = 0; i < btnCount; i++) {
        TabBarBtn *button = self.subviews[i];
        CGFloat buttonY = 0;
        CGFloat buttonW = self.frame.size.width / btnCount;
        CGFloat buttonX = i * buttonW;
        CGFloat buttonH = self.frame.size.height;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
}
- (void)setSelectIndex:(int)selectIndex
{
    TabBarBtn *b = (TabBarBtn *)[self viewWithTag:selectIndex] ;
    [self btnClick:b];
}

#pragma mark 监听按钮点击
- (void)btnClick:(TabBarBtn *)button
{
    if (_selectBtn == button)  return;
    
    // 1.通知代理
    if ([_delegate respondsToSelector:@selector(tabBar:didSelectButtonFrom:to:)]) {
        [_delegate tabBar:self didSelectButtonFrom:_selectBtn.tag to:button.tag];
    }
    
    // 2.切换按钮状态
    _selectBtn.selected = NO;
    button.selected = YES;
    _selectBtn = button;
}
- (NSInteger)currentSelectIndex
{
    return _selectBtn.tag - kTabBarBtnTag ;
}

@end











