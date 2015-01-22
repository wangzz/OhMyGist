//
//  FGDataManager.h
//  OhMyGist
//
//  Created by wangzz on 15-1-22.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FGError;
@class OCTClient;

typedef void (^completionBlock)(id object, FGError *error);

@interface FGDataManager : NSObject

/**
 *  异步登录接口
 *
 *  @param userName        用户名
 *  @param password        密码
 *  @param completionBlock 登录结果回调
 */
+ (void)loginWithUserName:(NSString *)userName password:(NSString *)password completionBlock:(completionBlock)completionBlock;


/**
 *  异步获取当前登录用户所有gists列表
 *
 *  @param client          当前登陆用户
 *  @param completionBlock 获取结果回调
 */
+ (void)fetchGists:(OCTClient *)client completionBlock:(completionBlock)completionBlock;


@end
