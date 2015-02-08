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
    RACDisposable   *_firstPageDisposable;
    RACDisposable   *_nextPageDisposable;
}

@end

@implementation FGStarredGistsManager

- (void)fetchStarredGistsFirstPageWithCompletionBlock:(completionBlock)completionBlock
{
    _page = 1;
    _firstPageDisposable = [[[[[[FGAccountManager defaultManager] client] fetchStarredGistsWithPage:_page] collect] deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(id x) {
        _firstPageDisposable = nil;
        completionBlock(x,nil);
    } error:^(NSError *error) {
        _firstPageDisposable = nil;
        completionBlock(nil,[FGError errorWith:error]);
    }];
}

- (void)fetchStarredGistsNextPageWithCompletionBlock:(completionBlock)completionBlock
{
    _page++;
    _nextPageDisposable = [[[[[[FGAccountManager defaultManager] client] fetchStarredGistsWithPage:_page] collect] deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(id x) {
        _nextPageDisposable = nil;
        completionBlock(x,nil);
    } error:^(NSError *error) {
        _nextPageDisposable = nil;
        completionBlock(nil,[FGError errorWith:error]);
    }];
}

- (void)cancelRequest
{
    [_firstPageDisposable dispose];
    [_nextPageDisposable dispose];
}

@end
