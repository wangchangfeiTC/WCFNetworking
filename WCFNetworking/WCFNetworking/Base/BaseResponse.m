//
//  BaseResponse.m
//  WCFNetworking
//
//  Created by mac on 16-9-22.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "BaseResponse.h"

@implementation BaseResponse

+ (void)initKeyMapper
{
  [JSONModel setGlobalKeyMapper:[
            [JSONKeyMapper alloc] initWithDictionary:@{@"id":@"eid",
                                                       @"description":@"descrip",
                                                       }
                                 ]
  ];
}

@end
