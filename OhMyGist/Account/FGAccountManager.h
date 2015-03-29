//
//  FGAccountManager.h
//  OhMyGist
//
//  Created by wangzz on 15-1-29.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OctoKit.h"
#import "FGError.h"

typedef void (^completionBlock)(id object, FGError *error);

@interface FGAccountManager : NSObject

+ (instancetype)defaultManager;

- (OCTClient *)client;

/**
 *  是否已登录
 */
- (BOOL)isAuthenticated;

/**
 *  注销
 */
- (void)logout;


/**
 *  登录接口
 *
 *  @param userName        用户名
 *  @param password        密码
 *  @param completionBlock 登录结果回调
 */
- (void)loginWithUserName:(NSString *)userName password:(NSString *)password completionBlock:(completionBlock)completionBlock;


- (void)logoutWithCompletionBlock:(completionBlock)completionBlock;


- (void)fetchUserInfoWithCompletionBlock:(completionBlock)completionBlock;

@end
