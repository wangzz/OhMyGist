//
//  FGError.h
//  OhMyGist
//
//  Created by wangzz on 15-1-22.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, FGErrorCode) {
    FGErrorCodeUnknown,
    FGErrorCodeRateLimit = 674,     //API RateLimit
};

@interface FGError : NSObject

@property (nonatomic) FGErrorCode code;

@property (nonatomic, copy) NSString *desc;

+ (instancetype)errorWith:(NSError *)error;

@end
