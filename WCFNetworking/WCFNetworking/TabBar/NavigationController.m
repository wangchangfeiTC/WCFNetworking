//
//  NavigationController.m
//  WCFNetworking
//
//  Created by mac on 15/12/10.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UINavigationBar *bar = [UINavigationBar appearance];
    
//    [bar setBackgroundImage:[self createImageWithColor:[UIColor orangeColor]]
//             forBarPosition:UIBarPositionAny
//                 barMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[UIImage new]];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0 ) {
        viewController.hidesBottomBarWhenPushed = YES;   //这个必须写在super前面, 否则跳转已经过了
    }
    [super pushViewController:viewController animated:animated];  //要写这个,否则不跳转了
}


- (void)pushViewControllerRetro:(UIViewController *)viewController {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.view.layer addAnimation:transition forKey:nil];
    
    [self pushViewController:viewController animated:NO];
}

- (void)popViewControllerRetro {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [self.view.layer addAnimation:transition forKey:nil];
    
    [self popViewControllerAnimated:NO];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end


















