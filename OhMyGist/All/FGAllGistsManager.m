//
//  FGAllGistsManager.m
//  OhMyGist
//
//  Created by wangzz on 15-1-29.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGAllGistsManager.h"

@interface FGAllGistsManager ()
{
    NSUInteger  _page;
    RACDisposable   *_firstPageDisposable;
    RACDisposable   *_nextPageDisposable;
}

@end

@implementation FGAllGistsManager


- (void)fetchAllGistsFirstPageWithCompletionBlock:(completionBlock)completionBlock
{
    _page = 1;
    _firstPageDisposable = [[[[[[FGAccountManager defaultManager] client] fetchAllGistsWithPage:_page] collect] deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(id x) {
//        
//        BOOL haveMorePage = [[[FGAccountManager defaultManager] client] haveMorePageAllGists];
//        NSLog(@"%d",haveMorePage);
        
        _firstPageDisposable = nil;
        completionBlock(x,nil);
    } error:^(NSError *error) {
        _firstPageDisposable = nil;
        completionBlock(nil,[FGError errorWith:error]);
    }];
}

- (void)fetchAllGistsNextPageWithCompletionBlock:(completionBlock)completionBlock
{
    _page++;
    _nextPageDisposable = [[[[[[FGAccountManager defaultManager] client] fetchAllGistsWithPage:_page] collect] deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(id x) {
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
