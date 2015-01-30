//
//  FGAllGistsManager.m
//  OhMyGist
//
//  Created by wangzz on 15-1-29.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGAllGistsManager.h"
#import "OctoKit.h"
#import "FGError.h"

@interface FGAllGistsManager ()

@end

@implementation FGAllGistsManager


- (void)fetchAllGistsFirstPageWithCompletionBlock:(completionBlock)completionBlock
{
    [[[[[FGAccountManager defaultManager] client] fetchAllGistsFirstPage] collect] subscribeNext:^(id x) {
        
        BOOL haveMorePage = [[[FGAccountManager defaultManager] client] haveMorePageAllGists];
        NSLog(@"%d",haveMorePage);
        
        completionBlock(x,nil);
    } error:^(NSError *error) {
        completionBlock(nil,[FGError errorWith:error]);
    }];
}

- (void)fetchAllGistsNextPageWithCompletionBlock:(completionBlock)completionBlock
{
    [[[[[FGAccountManager defaultManager] client] fetchAllGistsNextPage] collect] subscribeNext:^(id x) {
        completionBlock(x,nil);
    } error:^(NSError *error) {
        completionBlock(nil,[FGError errorWith:error]);
    }];
    
}

@end
