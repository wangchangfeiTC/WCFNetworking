//
//  HomeScoreModel.m
//  EFHealth
//
//  Created by nf on 17/2/20.
//  Copyright © 2017年 ef. All rights reserved.
//

#import "HomeDataModel.h"

//请求地址 example
NSString *const api_home_data = @"xxxxxx/m/homedata.action";

@implementation HomeDataModel

- (instancetype)initWithDelegate:(id)Delegate cache:(BOOL)cache
{
    if (self = [super initWithDelegate:Delegate cache:cache]) {
        self.parseModelClass = [HomeDataResponse class];
        self.cacheFileName = @"homedata";
    }
    return self ;
}
- (void)getHomeData
{
    [self getPath:api_home_data parameters:nil];
}


@end
