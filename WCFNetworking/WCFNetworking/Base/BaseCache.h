//
//  EFCache.h
//  WCFNetworking
//
//  Created by mac on 16/2/15.
//  Copyright (c) 2016年 mac. All rights reserved.
//
// cache基础类，包含文件的各种操作，以及文件的更新策略
//


#import <Foundation/Foundation.h>

//cache存储的文件夹
typedef enum cacheFolder{
    cacheFolder_home ,
    cacheFolder_data ,
    cacheFolder_message ,
    cacheFolder_me,
}cacheFolder;

/**** 文件更新频率 ****/
typedef enum FileUpdateRate{
    fileNeverUpdate ,       // 从不跟新
    fileOnceUpdate ,        // 跟新一次
    fileEveryUpdate ,       // 每次跟新
    fileEveryDayUpdate,     // 文件每天启动的时候更新
    fileOnedayUpdate,       // 每天跟新一次
    fileThreedayUpdate ,    // 3天跟新一次
    fileWeekUpdate ,        // 一星期跟新一次
    fileMonthUpdate ,       // 一月跟新一次
}FileUpdateRate;

typedef void(^EFCacheFileCompletionBlock)(BOOL result);

@interface BaseCache : NSObject

+ (BaseCache *)defaultCache  ;

@property (nonatomic,strong)NSString *fileName ;

/**
 *  写入/更新缓存(同步)
 *
 *  @param jsonResponse 要写入的数据(JSON)
 *  @param fileName     文件名
 *
 *  @return 是否写入成功
 */
+(BOOL)saveJsonResponseToCacheFile:(id)jsonResponse andFileName:(NSString *)fileName;

/**
 *  写入/更新缓存(异步)
 *
 *  @param jsonResponse    要写入的数据(JSON)
 *  @param fileName        文件名
 *  @param completedBlock  异步完成回调(主线程回调)
 */
+(void)saveAsyncJsonResponseToCacheFile:(id)jsonResponse andFileName:(NSString *)fileName completed:(EFCacheFileCompletionBlock)completedBlock;

/**
 *  获取缓存的对象(同步)
 *
 *  @param fileName 文件名
 *
 *  @return 缓存对象
 */
+(id )cacheJsonWithFileName:(NSString *)fileName;
+ (NSString *)cacheFilePathWithFileName:(NSString *)fileName;

/**
 * 删除对应缓存路径的数据
 */
+ (BOOL)deleteCacheWithFileName:(NSString *)fileName ;

/**
 *  获取缓存路径
 *
 *  @return 缓存路径
 */
+(NSString *)cachePath;

/**
 *  清除缓存
 */
+(BOOL)clearCache;

/**
 *  获取缓存大小(单位:M)
 *
 *  @return 缓存大小
 */
+ (float)cacheSize;

/**
 *  获取缓存大小,(以..kb/..M)形式获取
 *  小于1M,以kb形式返回,大于1M,以M形式返回
 *  @return 缓存大小+单位
 */
+(NSString *)cacheSizeFormat;

/**
 *  判断文件是否存在
 *
 *  @return 是否存在
 */
+ (BOOL)fileExistsAtPath:(NSString *)path;

/**
 *  文件更新策略方法
 *
 *  @return 是否需要更新
 */
+ (BOOL)updateFileWith:(FileUpdateRate)fileUpdateRate fileName:(NSString *)fileName;

@end






















