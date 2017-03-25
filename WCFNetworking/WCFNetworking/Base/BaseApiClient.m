//
//  EFApiClient.m
//  WCFNetworking
//
//  Created by mac on 16-11-28.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "BaseApiClient.h"
#import "Reachability.h"

#define BaseURL @"http://baidu.com"

@implementation BaseApiClient
+ (instancetype)sharedMClient
{
    static BaseApiClient *_sharedMClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        AFSecurityPolicy* policy = [[AFSecurityPolicy alloc] init];
        [policy setAllowInvalidCertificates:YES];
        _sharedMClient = [[BaseApiClient alloc] initWithBaseURL:[NSURL URLWithString:BaseURL]];
        [_sharedMClient setSecurityPolicy:policy];
        _sharedMClient.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sharedMClient.responseSerializer = [AFHTTPResponseSerializer serializer];
//         _sharedMClient.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithArray:@[@"POST", @"GET", @"HEAD"]];
        _sharedMClient.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedMClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/x-javascript",@"application/json", @"text/json", @"text/html", nil];
    });
    return _sharedMClient;
}

- (BOOL)isNetworkAvailable
{
    Reachability* newtorkReachbility = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [newtorkReachbility currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        return NO;
    }
    return YES;
}

@end






























