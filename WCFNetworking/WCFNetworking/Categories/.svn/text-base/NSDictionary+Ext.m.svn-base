//
//  NSDictionary+UrlEncoding.m
//  HHMusic
//
//  Created by liumadu on 14-9-22.
//  Copyright (c) 2014年 hengheng. All rights reserved.
//

#import "NSDictionary+Ext.h"

#import "NSString+Ext.h"

// helper function: get the string form of any object
static NSString *toString(id object) {
  return [NSString stringWithFormat: @"%@", object];
}

// helper function: get the url encoded string form of any object
static NSString *urlEncode(id object) {
  NSString *string = toString(object);
  return [string stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
}

@implementation NSDictionary (Ext)


+(NSDictionary *)nullDic:(NSDictionary *)myDic
{
    NSArray *keyArr = [myDic allKeys];
    NSMutableDictionary *resDic = [[NSMutableDictionary alloc]init];
    for (int i = 0; i < keyArr.count; i ++)
    {
        id obj = [myDic objectForKey:keyArr[i]];
        
        obj = [self changeType:obj];
        
        [resDic setObject:obj forKey:keyArr[i]];
    }
    return resDic;
}

//将NSDictionary中的Null类型的项目转化成@""
+(NSArray *)nullArr:(NSArray *)myArr
{
    NSMutableArray *resArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < myArr.count; i ++)
    {
        id obj = myArr[i];
        
        obj = [self changeType:obj];
        
        [resArr addObject:obj];
    }
    return resArr;
}

//将NSString类型的原路返回
+(NSString *)stringToString:(NSString *)string
{
    return string;
}

//将Null类型的项目转化成@""
+(NSString *)nullToString
{
    return @"";
}

#pragma mark - 公有方法
//将所有的NSNull类型转化成@""
+(id)changeType:(id)myObj
{
    if ([myObj isKindOfClass:[NSDictionary class]])
    {
        return [self nullDic:myObj];
    }
    else if([myObj isKindOfClass:[NSArray class]])
    {
        return [self nullArr:myObj];
    }
    else if([myObj isKindOfClass:[NSString class]])
    {
        return [self stringToString:myObj];
    }
    else if([myObj isKindOfClass:[NSNull class]])
    {
        return [self nullToString];
    }
    else
    {
        return myObj;
    }
}

-(NSString*) urlEncodedString {
  NSMutableArray *parts = [NSMutableArray array];
  for (id key in self) {
    id value = [self objectForKey: key];
    NSString *part = [NSString stringWithFormat: @"%@=%@", urlEncode(key), urlEncode(value)];
    [parts addObject: part];
  }
  return [parts componentsJoinedByString: @"&"];
}
- (BOOL)isNotEmpty
{
    return (![(NSNull *)self isEqual:[NSNull null]]
            && [self isKindOfClass:[NSDictionary class]]
            && self.count > 0);
}

- (NSArray *)arrayForKey:(id)aKey
{
    id object = [self objectForKey:aKey];
    if ([object isEqual:[NSNull null]]) {
        return nil;
    } else {
        if ([object isKindOfClass:[NSArray class]]) {
            return object;
        }
    }
    return nil;
}

- (NSDictionary *)dictionaryForKey:(id)aKey
{
    id object = [self objectForKey:aKey];
    if ([object isEqual:[NSNull null]]) {
        return nil;
    } else {
        if ([object isKindOfClass:[NSDictionary class]]) {
            return object;
        }
    }
    return nil;
}

- (NSString *)stringForKey:(id)aKey
{
    id object = [self objectForKey:aKey];
    if ([object isEqual:[NSNull null]]) {
        return @"";
    } else {
        if ([object isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)object stringValue];
        } else if ([object isKindOfClass:[NSString class]]) {
            return (NSString *)object;
        }
    }
    return @"";
}

- (NSInteger)integerForKey:(id)aKey
{
    id object = [self objectForKey:aKey];
    if ([object isEqual:[NSNull null]]) {
        return 0;
    } else {
        if ([object isKindOfClass:[NSString class]]) {
            return [(NSString *)object integerValue];
        } else if ([object isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)object integerValue];
        }
    }
    return 0;
}

- (int)intForKey:(id)aKey
{
    id object = [self objectForKey:aKey];
    if ([object isEqual:[NSNull null]]) {
        return (int)0;
    } else {
        if ([object isKindOfClass:[NSString class]]) {
            return [(NSString *)object intValue];
        } else if ([object isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)object intValue];
        }
    }
    return (int)0;
}

- (float)floatForKey:(id)aKey
{
    id object = [self objectForKey:aKey];
    if ([object isEqual:[NSNull null]]) {
        return (float)0;
    } else {
        if ([object isKindOfClass:[NSString class]]) {
            return [(NSString *)object floatValue];
        } else if ([object isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)object floatValue];
        }
    }
    return (float)0;
}

- (double)doubleForKey:(id)aKey
{
    id object = [self objectForKey:aKey];
    if ([object isEqual:[NSNull null]]) {
        return (double)0;
    } else {
        if ([object isKindOfClass:[NSString class]]) {
            return [(NSString *)object doubleValue];
        } else if ([object isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)object doubleValue];
        }
    }
    return (double)0;
}

- (BOOL)boolForKey:(id)aKey
{
    id object = [self objectForKey:aKey];
    if ([object isEqual:[NSNull null]]) {
        return NO;
    } else {
        if ([object isKindOfClass:[NSString class]]) {
            return [(NSString *)object boolValue];
        } else if ([object isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)object boolValue];
        }
    }
    return NO;
}

- (NSString *)paramString
{
    NSMutableArray *paramPairs = [NSMutableArray array];
    
    for (NSString *key in [self keyEnumerator]) {
        id value = [self valueForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            [paramPairs addObject:[NSString stringWithFormat:@"%@=%@",
                                   key, [(NSString *)value URLEncodedString]]];
        } else if ([value isKindOfClass:[NSNumber class]]) {
            [paramPairs addObject:[NSString stringWithFormat:@"%@=%@",
                                   key, [(NSNumber *)value stringValue]]];
        }
    }
    
    return [paramPairs componentsJoinedByString:@"&"];
}
@end
