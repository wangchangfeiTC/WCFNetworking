//
//  TabBarController.m
//  WCFNetworking
//
//  Created by mac on 15/12/10.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "TabBarController.h"

#import "HomeViewController.h"
#import "MessageViewController.h"
#import "FoundViewController.h"
#import "MeViewController.h"

#import "NavigationController.h"
#import "TabBar.h"

@interface TabBarController ()<TabBarDelegate,UITabBarDelegate,UITabBarControllerDelegate>

@end

@implementation TabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    [self.tabBar.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.tabBar.alpha = 0.95 ;
    
    HomeViewController *home = [[HomeViewController alloc]init];
    NavigationController *homeNav = [[NavigationController alloc]initWithRootViewController:home];
    
    MessageViewController *message = [[MessageViewController alloc]init];
    NavigationController *messageNav = [[NavigationController alloc]initWithRootViewController:message];
    
    FoundViewController *found = [[FoundViewController alloc]init];
    NavigationController *foundNav = [[NavigationController alloc]initWithRootViewController:found];
    
    MeViewController *me = [[MeViewController alloc]init];
    NavigationController *meNav = [[NavigationController alloc]initWithRootViewController:me];
    
    self.viewControllers = @[homeNav,messageNav,foundNav,meNav];
    self.delegate =self ;
    
    TabBar *tabbar = [[TabBar alloc]init];
    tabbar.delegate = self ;
    tabbar.frame = self.tabBar.bounds ;
    [self.tabBar addSubview:tabbar ];
    _groubeTabbar = tabbar ;
    
    NSArray *titleArray = @[@"首页",@"消息",@"发现",@"我"];
    NSArray *imgArray = @[@"tabbar_home",@"tabbar_message_center",@"tabbar_discover",@"tabbar_profile"];
    
    for (int i = 0;  i <self.viewControllers.count; i++) {
        
        NSString *selected = [imgArray[i] stringByAppendingString:@"_selected"];
        [tabbar addTabBarButton:imgArray[i] selIcon:selected title:titleArray[i]index:i+kTabBarBtnTag];
    }
}

- (void)tabBar:(TabBar *)tabBar didSelectButtonFrom:(NSUInteger)from to:(NSUInteger)to
{
    self.selectedIndex = to -kTabBarBtnTag ;
}


- (void)showViewControllerWithTag:(int)tag
{
    _groubeTabbar.selectIndex = tag +kTabBarBtnTag ;
    self.selectedIndex = tag ;
}
- (NSInteger)currentSelectIndex
{
    return _groubeTabbar.currentSelectIndex ;
}



@end
























