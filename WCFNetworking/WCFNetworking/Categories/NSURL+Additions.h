//
//  NSURL+Additions.h
//  HHMusic
//
//  Created by liumadu on 14-9-22.
//  Copyright (c) 2014年 hengheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (Additions)
// append query string to url
- (NSURL *)URLByAppendingQueryString:(NSString *)queryString;
@end
