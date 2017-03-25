//
//  BaseResponse.h
//  WCFNetworking
//
//  Created by mac on 16-9-22.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "JSONModel.h"

@interface BaseResponse : JSONModel

@property (nonatomic, assign) int code;
@property (nonatomic, assign) BOOL success;
@property (nonatomic, copy) NSString *msg;

+ (void)initKeyMapper;

@end
