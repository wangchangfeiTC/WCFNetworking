//
//  HomeViewController.m
//  WCFNetworking
//
//  Created by mac on 16/10/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeDataModel.h"

@interface HomeViewController ()<BaseModelProtocol>
@property (nonatomic,strong)HomeDataModel *dataModel;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"首页";
    
    //请求数据
    [self.dataModel getHomeData];
    NSLog(@"开始请求数据...");
}

- (void)getDataFinish:(BaseModel *)baseModel netError:(NSError *)error{

    NSLog(@"请求错误 %@",error);
}

- (void)getDataFinish:(BaseModel *)baseModel netResponse:(BaseResponse *)response{

    if ([baseModel isKindOfClass:[HomeDataModel class]]) {
        
        //返回的数据
        HomeDataResponse *resp = (HomeDataResponse *)response;
        //这里处理数据
    }
}

- (HomeDataModel *)dataModel{

    if (nil == _dataModel) {
        _dataModel = [[HomeDataModel alloc]initWithDelegate:self cache:NO];
    }
    return _dataModel;
}

@end
