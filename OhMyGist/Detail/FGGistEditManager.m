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

- (void)fetchFileContentWith:(OCTGist *)gist completionBlock:(completionBlock)completionBlock
{
    NSArray *filesArray = [gist.files allValues];
    if (gist == nil || filesArray.count == 0) {
        completionBlock(nil,nil);
        return;
    }
    
    NSMutableArray *editArray = [NSMutableArray array];
    dispatch_group_t group = dispatch_group_create();
    for (OCTGistFile *file in filesArray) {
        dispatch_group_async(group, dispatch_get_global_queue(0,0), ^{
            // 并行执行的线程一
            OCTGistFileEdit *fileEdit = [[OCTGistFileEdit alloc] init];
            fileEdit.filename = file.filename;
            NSError *error = nil;
            fileEdit.content = [NSString stringWithContentsOfURL:file.rawURL encoding:NSUTF8StringEncoding error:&error];
            if (!error) {
                [editArray addObject:fileEdit];
            }
        });
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        completionBlock(editArray,nil);
    });
}

@end
