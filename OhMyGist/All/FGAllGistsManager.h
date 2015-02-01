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
 *  fetch first page public gists
 * */
- (void)fetchAllGistsFirstPageWithCompletionBlock:(completionBlock)completionBlock;


/**
 *  fetch next page public gists
 * */
- (void)fetchAllGistsNextPageWithCompletionBlock:(completionBlock)completionBlock;

- (void)cancelRequest;

@end
