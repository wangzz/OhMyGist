//
//  FGPersonalGistsManager.m
//  OhMyGist
//
//  Created by wangzz on 15/1/31.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGPersonalGistsManager.h"
#import "OctoKit.h"
#import "FGError.h"

@interface FGPersonalGistsManager ()
{
    NSUInteger  _page;
}

@end

@implementation FGPersonalGistsManager

- (void)fetchPersonalGistsFirstPageWithCompletionBlock:(completionBlock)completionBlock
{
    _page = 1;
    [[[[[FGAccountManager defaultManager] client] fetchPersonalGistsWithPage:_page] collect] subscribeNext:^(id x) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(x,nil);
        });
    } error:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(nil,[FGError errorWith:error]);
        });
    }];
}

- (void)fetchPersonalGistsNextPageWithCompletionBlock:(completionBlock)completionBlock
{
    _page++;
    [[[[[FGAccountManager defaultManager] client] fetchPersonalGistsWithPage:_page] collect] subscribeNext:^(id x) {
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
