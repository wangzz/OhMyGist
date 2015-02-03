//
//  FGError.h
//  OhMyGist
//
//  Created by wangzz on 15-1-22.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import <Foundation/Foundation.h>

//https://github.com/octokit/octokit.objc/wiki/OCTClient-Errors
typedef NS_ENUM(NSUInteger, FGErrorCode) {
    FGErrorCodeUnknown,
    FGErrorCodeRateLimit = 674,             // API RateLimit
    FGErrorCodeLostConnection = 668,        // code:668 desc:The network connection was lost.
};

@interface FGError : NSObject

@property (nonatomic) FGErrorCode code;

@property (nonatomic, copy) NSString *desc;

+ (instancetype)errorWith:(NSError *)error;

@end
