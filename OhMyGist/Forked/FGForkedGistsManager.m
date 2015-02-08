//
//  FGForkedGistsManager.m
//  OhMyGist
//
//  Created by wangzz on 15/2/1.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGForkedGistsManager.h"

@interface FGForkedGistsManager ()
{
    NSUInteger  _page;
    RACDisposable   *_firstPageDisposable;
    RACDisposable   *_nextPageDisposable;
}

@end

@implementation FGForkedGistsManager

- (void)fetchForkedGistsFirstPageWithCompletionBlock:(completionBlock)completionBlock
{
    _page = 1;
    _firstPageDisposable = [[[[[[FGAccountManager defaultManager] client] fetchForkedGistsWithPage:_page] collect] deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(id x) {
        _firstPageDisposable = nil;
        completionBlock(x,nil);
    } error:^(NSError *error) {
        _firstPageDisposable = nil;
        completionBlock(nil,[FGError errorWith:error]);
    }];
}

- (void)fetchForkedGistsNextPageWithCompletionBlock:(completionBlock)completionBlock
{
    _page++;
    _nextPageDisposable = [[[[[[FGAccountManager defaultManager] client] fetchForkedGistsWithPage:_page] collect] deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(id x) {
        _nextPageDisposable = nil;
        completionBlock(x,nil);
    } error:^(NSError *error) {
        _nextPageDisposable = nil;
        completionBlock(nil,[FGError errorWith:error]);
    }];
}
@end
