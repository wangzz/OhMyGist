//
//  FGAddCommentManager.m
//  OhMyGist
//
//  Created by wangzz on 15-2-3.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGAddCommentManager.h"

@interface FGAddCommentManager ()
{
    RACDisposable   *_addCommentDisposable;
    RACDisposable   *_editCommentDisposable;
}

@end

@implementation FGAddCommentManager

- (void)addCommentWithGist:(OCTGist *)gist body:(NSString *)body completionBlock:(completionBlock)completionBlock
{
    _addCommentDisposable = [[[[[FGAccountManager defaultManager] client] addCommentWithGist:gist body:body] deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(id x) {
        _addCommentDisposable = nil;
        completionBlock(x,nil);
    } error:^(NSError *error) {
        _addCommentDisposable = nil;
        completionBlock(nil,[FGError errorWith:error]);
    }];
}

- (void)editCommentWithGist:(OCTGist *)gist comment:(OCTGistComment *)comment body:(NSString *)body completionBlock:(completionBlock)completionBlock
{
    _editCommentDisposable = [[[[[FGAccountManager defaultManager] client] editCommentWithGist:gist comment:comment body:body] deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(id x) {
        _editCommentDisposable = nil;
        completionBlock(x,nil);
    } error:^(NSError *error) {
        _editCommentDisposable = nil;
        completionBlock(nil,[FGError errorWith:error]);
    }];
}

- (void)cancelRequest
{
    [_addCommentDisposable dispose];
    [_editCommentDisposable dispose];
}

@end
