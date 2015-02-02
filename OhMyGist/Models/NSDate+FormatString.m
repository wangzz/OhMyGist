//
//  NSDate+FormatString.m
//  OhMyGist
//
//  Created by wangzz on 15-2-2.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "NSDate+FormatString.h"

@implementation NSDate (FormatString)

- (NSString*)stringFormat
{
#define ONE_MINUTE  (60)
#define ONE_HOUR  (60*ONE_MINUTE)
    //#define ONE_DAY    (24*ONE_HOUR)
#define ONE_DAY     ((((int)[curDate timeIntervalSince1970])%(24*ONE_HOUR))+((24*ONE_HOUR)))   //当天的小时+昨天一天时间
#define ONE_MONTH    (30*ONE_DAY)
    
    NSDate * curDate = [NSDate date];
    NSTimeInterval interval = [curDate timeIntervalSinceDate:self];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSString* szRet= nil;
    
    [dateFormatter setDateFormat:@"yyyy"];
    NSString* szyySelf = [dateFormatter stringFromDate:self];
    NSString* szyyCurYear = [dateFormatter stringFromDate:curDate];
    
    if (interval<= ONE_MINUTE) {
        return @"刚刚";
    }
    
    if (interval<= ONE_HOUR) {
        szRet = [NSString stringWithFormat:@"%d分钟前",(int)(interval/ONE_MINUTE)];
        return szRet;
    }
    if (interval<= ONE_DAY) {
        // 当天1小时前的显示今天具体时间（示例：今天 17：56）
        
        [dateFormatter setDateFormat:@"H:mm"];
        NSString* szHHMM = [dateFormatter stringFromDate:self];
        
        [dateFormatter setDateFormat:@"d"];
        NSString* szddSelf = [dateFormatter stringFromDate:self];
        NSString* szddCurDate = [dateFormatter stringFromDate:curDate];
        
        if ( [szddSelf isEqualToString:szddCurDate]) {
            szRet = [NSString stringWithFormat:@"今天%@",szHHMM];
        }
        else
        {
            szRet = [NSString stringWithFormat:@"昨天%@",szHHMM];
        }
        return szRet;
    }
    
    if([szyySelf isEqualToString:szyyCurYear]){
        //今年的
        [dateFormatter setDateFormat:@"M"];
        NSString* szMM = [dateFormatter stringFromDate:self];
        [dateFormatter setDateFormat:@"d"];
        NSString* szdd = [dateFormatter stringFromDate:self];
        szRet = [NSString stringWithFormat:@"%@月%@日",szMM,szdd];
        return szRet;
    }
    [dateFormatter setDateFormat:@"y"];
    NSString* szyy = [dateFormatter stringFromDate:self];
    [dateFormatter setDateFormat:@"M"];
    NSString* szMM = [dateFormatter stringFromDate:self];
    [dateFormatter setDateFormat:@"d"];
    NSString* szdd = [dateFormatter stringFromDate:self];
    szRet = [NSString stringWithFormat:@"%@年%@月%@日",szyy,szMM,szdd];
    return szRet;
}


@end
