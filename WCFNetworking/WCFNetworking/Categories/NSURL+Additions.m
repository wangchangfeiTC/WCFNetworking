//
//  NSURL+Additions.m
//  HHMusic
//
//  Created by liumadu on 14-9-22.
//  Copyright (c) 2014年 hengheng. All rights reserved.
//

#import "NSURL+Additions.h"

@implementation NSURL (Additions)

- (NSURL *)URLByAppendingQueryString:(NSString *)queryString {
  if (![queryString length]) {
    return self;
  }
  
  NSString *urlString = [[NSString alloc] initWithFormat:@"%@%@%@", [self absoluteString],
                         [self query] ? @"&" : @"?", queryString];
  NSURL *theURL = [NSURL URLWithString:urlString];
  return theURL;
}

@end
