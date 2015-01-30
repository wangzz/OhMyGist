//
//  FGAllGistsManager.h
//  OhMyGist
//
//  Created by wangzz on 15-1-29.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FGAccountManager.h"

@interface FGAllGistsManager : NSObject

/**
 *  获取All Gists
 *
 *  @param completionBlock 获取结果回调
 */
- (void)fetchAllGistsFirstPageWithCompletionBlock:(completionBlock)completionBlock;


- (void)fetchAllGistsNextPageWithCompletionBlock:(completionBlock)completionBlock;

@end
