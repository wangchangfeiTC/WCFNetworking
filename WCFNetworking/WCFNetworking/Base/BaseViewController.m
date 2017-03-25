//
//  BaseViewController.m
//  WCFNetworking
//
//  Created by mac on 15/12/10.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)dealloc
{
    [self removeNotification];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initView];
    [self addNotification];

}

- (void)initNavbar
{
    self.extendedLayoutIncludesOpaqueBars = YES ;
    self.edgesForExtendedLayout = UIRectEdgeBottom ;
    self.modalPresentationCapturesStatusBarAppearance = YES ;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    if (self.navigationController.viewControllers.count > 1 ) {

    }
}

- (void)initView
{
    
}

- (void)addNotification
{

}
- (void)removeNotification
{

}


@end
