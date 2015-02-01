//
//  FGGistDetailManager.m
//  OhMyGist
//
//  Created by wangzz on 15/2/1.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGGistDetailManager.h"

@interface FGGistDetailManager ()
{
    RACDisposable   *_detailDisposable;
}

@end

@implementation FGGistDetailManager

- (void)fetchDetailWithGist:(OCTGist *)gist completionBlock:(completionBlock)completionBlock
{
    _detailDisposable = [[[[FGAccountManager defaultManager] client] fetchDetailWithGist:gist] subscribeNext:^(id x) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _detailDisposable = nil;
            completionBlock(x,nil);
        });
    } error:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _detailDisposable = nil;
            completionBlock(nil,[FGError errorWith:error]);
        });
    }];
}

- (void)cancelRequest
{
    [_detailDisposable dispose];
}

@end
