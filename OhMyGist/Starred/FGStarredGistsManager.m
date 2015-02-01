//
//  FGStarredGistsManager.m
//  OhMyGist
//
//  Created by wangzz on 15/2/1.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGStarredGistsManager.h"

@interface FGStarredGistsManager ()
{
    NSUInteger  _page;
}

@end

@implementation FGStarredGistsManager

- (void)fetchStarredGistsFirstPageWithCompletionBlock:(completionBlock)completionBlock
{
    _page = 1;
    [[[[[FGAccountManager defaultManager] client] fetchStarredGistsWithPage:_page] collect] subscribeNext:^(id x) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(x,nil);
        });
    } error:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(nil,[FGError errorWith:error]);
        });
    }];
}

- (void)fetchStarredGistsNextPageWithCompletionBlock:(completionBlock)completionBlock
{
    _page++;
    [[[[[FGAccountManager defaultManager] client] fetchStarredGistsWithPage:_page] collect] subscribeNext:^(id x) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(x,nil);
        });
    } error:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(nil,[FGError errorWith:error]);
        });
    }];
}

@end
