//
//  FGStarredGistsManager.h
//  OhMyGist
//
//  Created by wangzz on 15/2/1.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FGAccountManager.h"

@interface FGStarredGistsManager : NSObject

/**
 *  fetch first page starred gists
 * */
- (void)fetchStarredGistsFirstPageWithCompletionBlock:(completionBlock)completionBlock;


/**
 *  fetch next page starred gists
 * */
- (void)fetchStarredGistsNextPageWithCompletionBlock:(completionBlock)completionBlock;

- (void)cancelRequest;

@end
