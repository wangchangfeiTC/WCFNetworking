//
//  TabBarController.h
//  WCFNetworking
//
//  Created by mac on 15/12/10.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TabBar.h"

@interface TabBarController : UITabBarController

@property (nonatomic,strong,readonly)TabBar *groubeTabbar ;
@property (nonatomic,assign,readonly)NSInteger currentSelectIndex ;
//选中第几个控制器
- (void)showViewControllerWithTag:(int)tag;

@end
