//
//  FGNetworkClient.m
//  OhMyGist
//
//  Created by wangzz on 15/1/14.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGNetworkClient.h"

//static NSString * const FGNetworkClientBaseURLString = @"https://api.github.com";
//
//@implementation FGNetworkClient
//
//+ (instancetype)sharedClient {
//    static FGNetworkClient *_sharedClient = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _sharedClient = [[FGNetworkClient alloc] initWithBaseURL:[NSURL URLWithString:FGNetworkClientBaseURLString]];
//        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
////        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
//    });
//    
//    return _sharedClient;
//}
//
//@end