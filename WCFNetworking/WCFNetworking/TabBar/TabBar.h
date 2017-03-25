//
//  TabBar.h
//  WCFNetworking
//
//  Created by mac on 15/12/10.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTabBarBtnTag  100

@class TabBar ;
@protocol TabBarDelegate <NSObject>

@optional
- (void)tabBar:(TabBar *)tabBar didSelectButtonFrom:(NSUInteger)from to:(NSUInteger)to;
@end


@interface TabBar : UIView
@property (nonatomic,weak)id<TabBarDelegate> delegate ;
@property (nonatomic,assign)int selectIndex ;//选中第几个按钮
@property (nonatomic,assign,readonly)NSInteger currentSelectIndex ;//目前选中的按钮

- (void)addTabBarButton:(NSString *)icon selIcon:(NSString *)selIcon  title:(NSString *)title index:(int)index;
@end
