//
//  EFCache.m
//  WCFNetworking
//
//  Created by mac on 16/2/15.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "BaseCache.h"

#import <CommonCrypto/CommonDigest.h>

@implementation BaseCache

+ (BaseCache *)defaultCache
{
    static BaseCache *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[BaseCache alloc] init];
    });
    return _instance;
}

- (id)init
{
    if (self = [super init]){
    }
    return self ;
}

+ (BOOL)saveJsonResponseToCacheFile:(id)jsonResponse andFileName:(NSString *)fileName
{
    if(jsonResponse == nil) return NO;
    if(fileName == nil) return  NO;
    NSData * data= [self jsonToData:jsonResponse];
    return[[NSFileManager defaultManager] createFileAtPath:[self cacheFilePathWithFileName:fileName] contents:data attributes:nil];
}

+ (void)saveAsyncJsonResponseToCacheFile:(id)jsonResponse andFileName:(NSString *)fileName completed:(EFCacheFileCompletionBlock)completedBlock;
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
       __block BOOL result=[self saveJsonResponseToCacheFile:jsonResponse andFileName:fileName];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(completedBlock)
            {
                completedBlock(result);
            }
        });
    });
}

+ (id)cacheJsonWithFileName:(NSString *)fileName
{
    NSString *path = [self cacheFilePathWithFileName:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path isDirectory:nil] == YES) {
        NSData *data = [fileManager contentsAtPath:path];
        id datajson = [self dataToJson:data];
        NSLog(@"读出的cache数据====%@",datajson);
        return datajson  ;
    }
    return nil;
}

+ (NSString *)cacheFilePathWithFileName:(NSString *)fileName {
    
    NSString *path = [self cachePath];
    [self checkDirectory:path];
//    NSString *cacheFileNameString = [NSString stringWithFormat:@"%@ AppVersion:%@",fileName,[self appVersionString]];
    //NSString *cacheFileName = [self md5StringFromString:cacheFileNameString];
//    path = [path stringByAppendingPathComponent:cacheFileNameString];
    path = [path stringByAppendingPathComponent:fileName];
    NSLog(@"cachePath = %@",path);
    return path;
}
+ (BOOL)deleteCacheWithFileName:(NSString *)fileName
{
    return YES ;
}
+ (NSString *)cachePath
{
    NSString *pathOfCache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [pathOfCache stringByAppendingPathComponent:@"EFjiankangbahe_cache"];
    return path;
}

+ (NSData *)jsonToData:(id)jsonResponse
{
    if(jsonResponse==nil) return nil;
    NSError *error;
    NSData *data =[NSJSONSerialization dataWithJSONObject:jsonResponse options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"ERROR, faild to get json data");
        return nil;
    }
    return data;
}

+ (id)dataToJson:(NSData *)data
{
    if(data==nil) return nil;
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}

+(void)checkDirectory:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if (![fileManager fileExistsAtPath:path isDirectory:&isDir]) {
        [self createBaseDirectoryAtPath:path];
    } else {
        
        if (!isDir) {
            NSError *error = nil;
            [fileManager removeItemAtPath:path error:&error];
            [self createBaseDirectoryAtPath:path];
        }
    }
}

+ (void)createBaseDirectoryAtPath:(NSString *)path {
    __autoreleasing NSError *error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES
                                               attributes:nil error:&error];
    if (error) {
        NSLog(@"create cache directory failed, error = %@", error);
    } else {
        
        NSLog(@"path = %@",path);
        [self addDoNotBackupAttribute:path];
    }
}

+ (void)addDoNotBackupAttribute:(NSString *)path {
    NSURL *url = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    [url setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
    if (error) {
        NSLog(@"error to set do not backup attribute, error = %@", error);
    }
}

+ (NSString *)md5StringFromString:(NSString *)string {
    
    if(string == nil || [string length] == 0)  return nil;
    
    const char *value = [string UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

+ (NSString *)appVersionString {
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (BOOL)clearCache
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [self cachePath];
    BOOL result = [fileManager removeItemAtPath:path error:nil];
    [self checkDirectory:[self cachePath]];
    return result;
}

+ (float)cacheSize{
    NSString *directoryPath = [self cachePath];
    BOOL isDir = NO;
    unsigned long long total = 0;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:&isDir]) {
        if (isDir) {
            NSError *error = nil;
            NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directoryPath error:&error];
            
            if (error == nil) {
                for (NSString *subpath in array) {
                    NSString *path = [directoryPath stringByAppendingPathComponent:subpath];
                    NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:path
                                                                                          error:&error];
                    if (!error) {
                        total += [dict[NSFileSize] unsignedIntegerValue];
                    }
                }
            }
        }
    }
    return total/(1024.0*1024.0);
}

+ (NSString *)cacheSizeFormat
{
    NSString *sizeUnitString;
    float size = [self cacheSize];
    if(size < 1)
    {
        size *= 1024.0;//小于1M转化为kb
        sizeUnitString = [NSString stringWithFormat:@"%.1fkb",size];
    }
    else{
        
        sizeUnitString = [NSString stringWithFormat:@"%.1fM",size];
    }
    
    return sizeUnitString;
}

+ (BOOL)fileExistsAtPath:(NSString *)path
{
    if (nil == path) return NO ;
    return [[NSFileManager defaultManager]fileExistsAtPath:path];
}

//文件至今多少天
+ (NSInteger)dateEarlierNow:(NSString *)fileName
{
    if (nil == fileName) return 0    ;
    if ([self fileExistsAtPath:[self cacheFilePathWithFileName:fileName]] == NO) return 0 ;
    
    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:fileName error:nil];
    if (fileAttributes) {
        NSDate *createDate = (NSDate *)[fileAttributes objectForKey:NSFileCreationDate];
        if (nil == createDate)  return 0 ;
        
        NSDate *today = [NSDate date ];
        NSTimeInterval interVal = [today timeIntervalSinceDate:createDate];
        //转换为天数
        NSInteger day = (NSInteger)((int)interVal/86400);
        return day ;
    }else{
        return 0 ;
    }
}

//文件是否是在前一天或是前多少天缓存的
+ (BOOL)fileIsBeforeDayCacheWithFileName:(NSString *)fileName
{
    if (nil == [self cacheFilePathWithFileName:fileName]) return NO ;
    if ([self fileExistsAtPath:[self cacheFilePathWithFileName:fileName]] == NO) return NO ;
    
    NSDictionary *fileAtt = [[NSFileManager defaultManager] attributesOfItemAtPath:[self cacheFilePathWithFileName:fileName] error:nil];
    if (fileAtt) {
        NSDate *createDate = (NSDate *)[fileAtt objectForKey:NSFileModificationDate];
        if (nil == createDate) return NO ;
        
        NSDateFormatter *format1 = [[NSDateFormatter alloc]init];
        [format1 setDateFormat:@"yyyy-MM-dd"];
        NSString *s1 = [format1 stringFromDate:createDate];
        
        NSDate *today = [NSDate date];
        NSDateFormatter *format2 = [[NSDateFormatter alloc]init];
        [format2 setDateFormat:@"yyyy-MM-dd"];
        NSString *s2 = [format2 stringFromDate:today];
        
        //当前日期和存储文件日期一样 不需要跟新
        if ([s1 isEqualToString:s2])  return NO ;
    }
    
    return YES ;
}

//文件更新策略方法
+ (BOOL)updateFileWith:(FileUpdateRate)fileUpdateRate fileName:(NSString *)fileName
{
    //本地都不存在，需要马上更新
    if ([self fileExistsAtPath:[self cacheFilePathWithFileName:fileName]] == NO)  return YES ;
    
    //到这里说明本地已有一份cache
    if (fileUpdateRate == fileNeverUpdate)  return NO ;
    
    if (fileUpdateRate == fileOnceUpdate) return NO ;
    
    if (fileUpdateRate == fileEveryUpdate) return YES ;
    
    //判断是否是同一天存在的缓存
    if (fileUpdateRate == fileEveryDayUpdate) {
        return [self fileIsBeforeDayCacheWithFileName:fileName];
    }
    
    //获取当前文件至今的日子
    NSInteger days = [self dateEarlierNow:[self cacheFilePathWithFileName:fileName]];
    
    if (days>=1 && fileUpdateRate==fileOnedayUpdate) return YES ;
    if (days>=3 && fileUpdateRate==fileThreedayUpdate ) return YES;
    if (days>=7 && fileUpdateRate==fileWeekUpdate) return YES;
    if (days>=30&& fileUpdateRate==fileMonthUpdate) return YES;
    
    return NO;
}


@end


























