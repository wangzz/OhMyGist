//
//  FGAddCommentManager.h
//  OhMyGist
//
//  Created by wangzz on 15-2-3.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FGAccountManager.h"

@interface FGAddCommentManager : NSObject

- (void)addCommentWithGist:(OCTGist *)gist body:(NSString *)body completionBlock:(completionBlock)completionBlock;

- (void)editCommentWithGist:(OCTGist *)gist comment:(OCTGistComment *)comment body:(NSString *)body completionBlock:(completionBlock)completionBlock;

- (void)cancelRequest;

@end
