//
//  FGPersonalGistsManager.h
//  OhMyGist
//
//  Created by wangzz on 15/1/31.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FGAccountManager.h"

@interface FGPersonalGistsManager : NSObject

/**
 *  fetch first page personal gists
 * */
- (void)fetchPersonalGistsFirstPageWithCompletionBlock:(completionBlock)completionBlock;


/**
 *  fetch next page personal gists
 * */
- (void)fetchPersonalGistsNextPageWithCompletionBlock:(completionBlock)completionBlock;

@end
