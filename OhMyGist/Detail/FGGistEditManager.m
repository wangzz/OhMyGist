//
//  FGGistEditManager.m
//  OhMyGist
//
//  Created by wangzz on 15/2/20.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGGistEditManager.h"
#import "OCTClient+Gists.h"

@interface FGGistEditManager ()
{
    RACDisposable   *_createGistDisposable;
    RACDisposable   *_editGistDisposable;
}


@end

@implementation FGGistEditManager

- (void)createGistWithEdit:(OCTGistEdit *)edit completionBlock:(completionBlock)completionBlock
{
    _createGistDisposable = [[[[FGAccountManager defaultManager].client createGistWithEdit:edit] deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(id x) {
        _createGistDisposable = nil;
        completionBlock(x,nil);
    } error:^(NSError *error) {
        _createGistDisposable = nil;
        completionBlock(nil,[FGError errorWith:error]);
    }];
}

- (void)editGistWithEdit:(OCTGistEdit *)edit gist:(OCTGist *)gist completionBlock:(completionBlock)completionBlock
{
    _editGistDisposable = [[[[FGAccountManager defaultManager].client applyEdit:edit toGist:gist] deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(id x) {
        _editGistDisposable = nil;
        completionBlock(x,nil);
    } error:^(NSError *error) {
        _editGistDisposable = nil;
        completionBlock(nil,[FGError errorWith:error]);
    }];
}

- (void)cancelRequest
{
    [_createGistDisposable dispose];
    [_editGistDisposable dispose];
}

@end
