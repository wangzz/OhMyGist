//
//  NSString+Format.m
//  OhMyGist
//
//  Created by wangzz on 15/2/20.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "NSString+Format.h"

@implementation NSString (Format)

+ (NSString *)stringWithBytes:(NSUInteger)bytes
{
    NSUInteger unit = 1024;
    if (bytes < unit) {
        return [NSString stringWithFormat:@"%luB",(unsigned long)bytes];
    } else if (bytes < pow(unit, 2)) {
        return [NSString stringWithFormat:@"%luKB",(unsigned long)bytes/unit];
    } else if (bytes < pow(unit, 3)) {
        return [NSString stringWithFormat:@"%.0fMB",(unsigned long)bytes/(pow(unit, 2))];
    } else if (bytes < pow(unit, 4)) {
        return [NSString stringWithFormat:@"%.0fGB",(unsigned long)bytes/(pow(unit, 3))];
    }
    
    return nil;
}

static const char units[] = {'\0', 'k', 'M', 'G', 'T', 'P', 'E', 'Z', 'Y'};
static const int precisions[] = {0, 0, 1, 2, 2, 4, 4, 4, 4};
static NSNumberFormatter* formatter;

+ (NSString *)stringFromBytes:(double)bytes
{
    int multiplier = 1024;
    int exponent = 0;
    
    while(bytes >= multiplier && exponent < (sizeof units - 1)){
        bytes /= multiplier;
        exponent++;
    }
    
    if(formatter == nil){
        formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
    }
    formatter.maximumFractionDigits = precisions[exponent];
    formatter.minimumFractionDigits = precisions[exponent];
    
    // Beware of reusing this format string. -[NSString stringWithFormat] ignores \0, *printf does not.
    return [NSString stringWithFormat:@"%@ %cB", [formatter stringFromNumber:[NSNumber numberWithDouble: bytes]], units[exponent]];
}


@end
