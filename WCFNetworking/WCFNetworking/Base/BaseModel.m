//
//  BaseModel.m
//  WCFNetworking
//
//  Created by nf on 16/10/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BaseModel.h"
#import "TFHpple.h"

#define VersionTag  @"1.1" //接口版本
NSString *const api_upLoadImage = @"http://www.baidu.com/upload";//上传头像

typedef  void (^SuccessBlock)(NSURLSessionDataTask * _Nonnull, id _Nullable);
typedef  void (^FailureBlock)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull);
typedef void (^ProgressBlock)(NSProgress * _Nonnull);
@interface BaseModel()
{
    NSURLSessionDataTask *_operation ;
}

@property (nonatomic,weak)id<BaseModelProtocol> Delegate ;
@property (nonatomic,assign)BOOL needCache ;

@end

@implementation BaseModel

- (instancetype)initWithDelegate:(id<BaseModelProtocol>)Delegate cache:(BOOL)cache
{
    if (self = [super init]) {
        self.Delegate = Delegate ;
        self.needCache = cache ;
    }
    return self ;
}

//url中公共参数<user中用>
- (NSDictionary *)commonParameters
{
    NSMutableDictionary *commP = [NSMutableDictionary dictionaryWithCapacity:2];
    [commP setValue:VersionTag forKey:@"version"];
    [commP setValue:@"ios" forKey:@"platform"];
    return commP;
}

//全局单例 数据下载接口头部<user不需要cookie参数，所以user接口不需要它>
- (BaseApiClient *)getClient
{
    NSAssert(_Delegate, @"没有设置代理");
    NSAssert(_parseModelClass, @"数据解析class没有设置");
    if (_needCache && (_cacheFileName.length == 0)) {
        NSAssert(NO, @"需要缓存数据，但是没有设置缓冲文件名");
    }
    
    BaseApiClient* client = [BaseApiClient sharedMClient];
    NSString *cookie = @"";
    [client.requestSerializer setValue:cookie forHTTPHeaderField:@"cookie"];
    return client;
}
- (void)cancelRequest
{
    if (_operation.state != NSURLSessionTaskStateCanceling) {
        [_operation cancel];
    }
}
- (void)cancelAllRequest
{
    [[BaseApiClient sharedMClient].operationQueue cancelAllOperations];
}

- (SuccessBlock)getSuccessBlock:(id)weakSelf
{
    return ^(NSURLSessionDataTask * _Nonnull request, id _Nullable response){
        __weak __typeof(self) weakSelf = self;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([response isKindOfClass:[NSDictionary class]]) {
                NSDictionary* responseDict = [NSDictionary dictionaryWithDictionary:(NSDictionary*)response];
                //将返回值responseDict中所有的NSNull类型转化成@""
                responseDict = [NSDictionary changeType:responseDict];
                NSLog(@"responseDict = %@",responseDict);
                NSError* error = nil;
                BaseResponse* responseModel = nil;
                @try {
                    responseModel = [[[_parseModelClass class] alloc] initWithDictionary:responseDict error:&error];
                    
                }@catch (NSException *exception) {
                    NSLog(@"数据解析出错 error:%@ == %@  ==== %@", weakSelf,exception,error);
                }
                
                /**
                 * code =0 正确 code=-1异常 code=2001密码错误 code=2002登录失效
                 */
                if (nil == responseModel || error) {
                    responseModel = [[BaseResponse alloc]initWithDictionary:responseDict error:&error];
                }
                
                if (responseModel.code == 0 && nil == error && nil != responseModel) {//数据正常
                    
                    //如果需要保存缓存
                    if (self.needCache && self.cacheFileName != nil) {
                        [BaseCache saveJsonResponseToCacheFile:response andFileName:self.cacheFileName];
                    }
                    //通知代理处理数据
                    if (self.Delegate && [self.Delegate respondsToSelector:@selector(getDataFinish:netResponse:)]) {
                        [self.Delegate getDataFinish:weakSelf netResponse:responseModel];
                    }
                }
                else{
                    
                    if (responseModel.code == 2001) {//密码错误
                        error = [NSError errorWithDomain:responseModel.msg code:apiErrorCodePsdError userInfo:nil];
                    }
                    else if(responseModel.code == 2002){//登录失效
                        error = [NSError errorWithDomain:responseModel.msg code:apiErrorCodeNoLogin userInfo:nil];
                    }
                    else if (responseModel.code != 0) {//说明后台处理了错误信息
                        
                        if (responseModel.msg.length == 0) {
                            responseModel.msg = @"后台错误";
                        }
                        error = [NSError errorWithDomain:responseModel.msg code:apiErrorCodeResultError userInfo:nil];
                    }
                    else{
                        error = [NSError errorWithDomain:@"解析错误" code:apiErrorCodePrasultError userInfo:nil];
                    }
                    
                    if (self.Delegate && [self.Delegate respondsToSelector:@selector(getDataFinish:netError:)]) {
                        [self.Delegate getDataFinish:weakSelf netError:error];
                    }
                    
                }
            }
            else{
                
                NSError *error = [NSError errorWithDomain:@"数据错误(-1024)" code:apiErrorCodeNoDictionary userInfo:nil];
                
                if (self.Delegate && [_Delegate respondsToSelector:@selector(getDataFinish:netError:)]) {
                    [self.Delegate getDataFinish:weakSelf netError:error];
                }
            }
        });
        
    };
}
- (FailureBlock)getFailureBlock:(id)weakSelf
{
    return ^(NSURLSessionDataTask * _Nullable request, NSError * _Nonnull error){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (request.state != NSURLSessionTaskStateCanceling) {//这是网络错误
                
                NSMutableString *errorStr = [NSMutableString stringWithString:@"网络错误"];
                NSInteger responseCode = ((NSHTTPURLResponse *)request.response).statusCode ;
               [errorStr appendFormat:@"(%zd_%zd)",error.code,((NSHTTPURLResponse *)request.response).statusCode ];//3840 404  -1001请求超时 -1003未能找到使用指定主机名的服务器
            
                NSError *errorN = [NSError errorWithDomain:errorStr code:apiErrorCodeNetNo userInfo:nil];
               
                if (self.Delegate && [_Delegate respondsToSelector:@selector(getDataFinish:netError:)]) {
                    [self.Delegate getDataFinish:weakSelf netError:errorN];
                }
                NSLog(@"网络错误：%@",error);
            }
            else{//这是取消请求
                
                NSLog(@"==========取消请求===== %@",request);
            }
    });
    };
}
- (ProgressBlock)getProgressBlock:(id)weakSelf
{
    return ^(NSProgress * _Nonnull downloadProgress){
        NSLog(@"下载进度%@ %zd = %zd \n\n\n",weakSelf,downloadProgress.totalUnitCount , downloadProgress.completedUnitCount);
    };
}

- (void)upLoadImage:(UIImage *)image scale:(float)scale
{
    NSData *imgData = UIImageJPEGRepresentation(image, scale);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    __weak __typeof(self) weakSelf = self;
    [manager POST:api_upLoadImage parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imgData name:@"userfile123" fileName:@"userfile123.jpg" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        TFHpple *hpple=[[TFHpple alloc] initWithHTMLData:responseObject];
        NSArray * elements  = [hpple searchWithXPathQuery:@"//h1"];
        TFHppleElement * element = [elements objectAtIndex:0];
        NSString *MD5Photo=[element.text substringFromIndex:[element.text rangeOfString:@"MD5: "].length];
        NSString *imgURL = [NSString stringWithFormat:@"http://mbank.nf1000.com/simg/%@",MD5Photo] ;
        
        if (_Delegate && [_Delegate respondsToSelector:@selector(getUpLoadImageSuccess:)]) {
            
            [_Delegate getUpLoadImageSuccess:imgURL];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (_Delegate && [_Delegate respondsToSelector:@selector(getDataFinish:netError:)]) {
            [_Delegate getDataFinish:weakSelf netError:error];
        }
    }];
}
- (void)postPath:(NSString *)path parameters:(NSDictionary *)parameters
{
    BaseApiClient *client = [self getClient];
    NSString *commonParameters = [[self commonParameters] urlEncodedString];
    NSString *newPath = [path URLStringByAppendingQueryString:commonParameters];
    
    _parameterDict = parameters ;
    __weak __typeof(self) weakSelf = self;
    _operation = [client POST:newPath  parameters:parameters
                     progress:[self getProgressBlock:weakSelf]
                      success:[self getSuccessBlock:weakSelf]
                      failure:[self getFailureBlock:weakSelf]];
}
- (void)getPath:(NSString *)path parameters:(NSDictionary *)parameters
{
    BaseApiClient *client = [self getClient];
    NSString *commonParameters = [[self commonParameters] urlEncodedString];
    NSString *newPath = [path URLStringByAppendingQueryString:commonParameters];
    
    _parameterDict = parameters ;
    __weak __typeof(self) weakSelf = self;
    _operation = [client GET:newPath parameters:parameters
                    progress:[self getProgressBlock:weakSelf]
                     success:[self getSuccessBlock:weakSelf]
                     failure:[self getFailureBlock:weakSelf]];
}



- (void)readCacheDataWithCallback:(cacheDataCallback)cacheCallback
{
    
    if (self.cacheFileName) {//有缓存
        id response = [BaseCache cacheJsonWithFileName:self.cacheFileName];
        if (response) {
            
            if ([response isKindOfClass:[NSDictionary class]]) {
                
                NSDictionary* responseDict = [NSDictionary dictionaryWithDictionary:(NSDictionary*)response];
                NSError* error = nil;
                BaseResponse* responseModel = nil;
                @try {
                    responseModel = [[[_parseModelClass class] alloc] initWithDictionary:responseDict error:&error];
                }@catch (NSException *exception) {
                    NSLog(@"缓存数据解析出错 error:%@ == %@  ==== %@", self,exception,error);
                    NSAssert(NO, @"cache data analysis error");
                }
                
                if (nil != responseModel && !error) {
                    
                    cacheCallback(responseModel,nil);
                }else{
                    NSError *error = [NSError errorWithDomain:@"解析错误" code:0 userInfo:nil];
                    cacheCallback(nil,error);
                    [BaseCache deleteCacheWithFileName:self.cacheFileName];
                }
            }else{
                
                NSError *error = [NSError errorWithDomain:@"数据错误" code:0 userInfo:nil];
                cacheCallback(nil,error);
            }
        }
        else{
            NSError *error = [NSError errorWithDomain:@"无缓存" code:0 userInfo:nil];
            cacheCallback(nil,error);
        }
    }
    else{
        NSError *error = [NSError errorWithDomain:@"无缓存文件夹" code:1 userInfo:nil];
        cacheCallback(nil,error);
    }
}


@end

















