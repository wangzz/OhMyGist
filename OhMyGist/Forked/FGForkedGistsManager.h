//
//  FGForkedGistsManager.h
//  OhMyGist
//
//  Created by wangzz on 15/2/1.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FGAccountManager.h"

@interface FGForkedGistsManager : NSObject

/**
 *  fetch first page forked gists
 * */
- (void)fetchForkedGistsFirstPageWithCompletionBlock:(completionBlock)completionBlock;


/**
 *  fetch next page forked gists
 * */
- (void)fetchForkedGistsNextPageWithCompletionBlock:(completionBlock)completionBlock;


@end
