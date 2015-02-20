//
//  NSString+Format.h
//  OhMyGist
//
//  Created by wangzz on 15/2/20.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Format)

+ (NSString *)stringWithBytes:(NSUInteger)bytes;

+ (NSString *)stringFromBytes:(double)bytes;

@end
