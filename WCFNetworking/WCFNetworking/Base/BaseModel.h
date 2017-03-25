//
//  BaseModel.h
//  WCFNetworking
//
//  Created by mac on 16/10/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "BaseApiClient.h"
#import "BaseResponse.h"
#import "NSDictionary+Ext.h"
#import "NSString+Ext.h"

#import "BaseCache.h"

#import "BaseResponse.h"

typedef NS_ENUM(NSInteger , apiErrorCode) {
    
    apiErrorCodeNetError = 1 ,       //无网络
    apiErrorCodeNetNo = 2 ,          //网络错误
    apiErrorCodeCancelRequest= 3 ,   //取消请求
    
    apiErrorCodePrasultError = 4 ,   //解析错误
    apiErrorCodeResultError =  5 ,   //结果错误
    apiErrorCodeStatusNoZero = 6 ,   //代码非0
    apiErrorCodeNoDictionary = 7 ,   //解析错误
    
    apiErrorCodeNoLogin      = 8 ,  //未登录错误      后台接口返回2002
    apiErrorCodePsdError     = 9 ,  //登录密码错误    后台接口返回2001
    
};

typedef void (^getNetDataFinishResponse) (BaseResponse  * response , NSError *error);

typedef void (^cacheDataCallback)(BaseResponse *response ,NSError *error);

typedef void (^getUpLoadImageResponse)(NSString *imageURL , NSError *error);

@class BaseModel ;

@protocol BaseModelProtocol <NSObject>


//网络数据下载成功
- (void)getDataFinish:(BaseModel *)baseModel netResponse:(BaseResponse *)response ;
//网络数据下载数据失败
- (void)getDataFinish:(BaseModel *)baseModel netError:(NSError *)error ;

@optional
//上传图片成功
- (void)getUpLoadImageSuccess:(NSString *)imageURL ;

@end

@interface BaseModel : NSObject

//缓存文件名称
@property (nonatomic,strong)NSString *cacheFileName ;

//数据解析字段名称
@property (nonatomic,strong)Class parseModelClass ;

//方法请求的参数
@property (nonatomic,strong,readonly)NSDictionary *parameterDict ;

//初始化
- (instancetype)initWithDelegate:(id<BaseModelProtocol>)Delegate cache:(BOOL)cache;

//get方法请求网络
- (void)getPath:(NSString*)path parameters:(NSDictionary*)parameters ;
//post方法请求网络
- (void)postPath:(NSString *)path parameters:(NSDictionary *)parameters ;

//上传图片到服务器 scale压缩比例
- (void)upLoadImage:(UIImage *)image scale:(float)scale ;

//取消请求 《如果是请求东西比较多。可以考虑在dealoc中调用这个方法取消请求》
- (void)cancelRequest ;

//取消所有请求
- (void)cancelAllRequest ;

//读取缓冲数据
- (void)readCacheDataWithCallback:(cacheDataCallback)cacheDataCallback ;

@end







