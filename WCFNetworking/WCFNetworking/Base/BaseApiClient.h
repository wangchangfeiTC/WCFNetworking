//
//  EFApiClient.h
//  WCFNetworking
//
//  Created by mac on 16-11-28.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface BaseApiClient : AFHTTPSessionManager
//  xxxx.com 接口
+ (instancetype)sharedMClient;

- (BOOL)isNetworkAvailable;//  网络是否可见

@end


