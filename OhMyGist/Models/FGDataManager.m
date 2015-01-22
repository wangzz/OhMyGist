//
//  FGDataManager.m
//  OhMyGist
//
//  Created by wangzz on 15-1-22.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGDataManager.h"
#import "OctoKit.h"
#import "FGError.h"


@implementation FGDataManager

+ (void)loginWithUserName:(NSString *)userName password:(NSString *)password completionBlock:(completionBlock)completionBlock
{
    OCTUser *user = [OCTUser userWithRawLogin:userName server:OCTServer.dotComServer];
    [[OCTClient signInAsUser:user password:password oneTimePassword:nil scopes:OCTClientAuthorizationScopesUser note:nil noteURL:nil fingerprint:nil] subscribeNext:^(OCTClient *authenticatedClient) {
         //Authentication was successful. Do something with the created client.
         NSLog(@"%@",authenticatedClient);
         completionBlock(authenticatedClient,nil);
     } error:^(NSError *error) {
         // Authentication failed.
         NSLog(@"%@",error);
         completionBlock(nil,[FGError errorWith:error]);
     }];
}

+ (void)fetchGists:(OCTClient *)client completionBlock:(completionBlock)completionBlock
{
    [[[client fetchGists] collect] subscribeNext:^(NSArray *repositories) {
        // Thanks to -collect, this block is invoked after the request completes,
        // with _all_ the results that were received.
        if (completionBlock && [repositories.firstObject isKindOfClass:[OCTGist class]]) {
            completionBlock(repositories,nil);
        }
    } error:^(NSError *error) {
        // Invoked when an error occurs. You won't receive any results if this
        // happens.
        NSLog(@"%@",error);
        if (completionBlock) {
            completionBlock(nil,[FGError errorWith:error]);
        }
    }];
}

+ (void)fetchUserInfo:(OCTClient *)client completionBlock:(completionBlock)completionBlock
{
    [[client fetchUserInfo] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    } error:^(NSError *error) {
        NSLog(@"%@",error);
        if (completionBlock) {
            completionBlock(nil,[FGError errorWith:error]);
        }
    }];
}

+ (void)fetchUserRepositories:(OCTClient *)client completionBlock:(completionBlock)completionBlock
{
    [[[client fetchUserRepositories] collect] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    } error:^(NSError *error) {
        NSLog(@"%@",error);
        if (completionBlock) {
            completionBlock(nil,[FGError errorWith:error]);
        }
    }];
}


+ (void)fetchPublicGists:(OCTClient *)client completionBlock:(completionBlock)completionBlock
{
    [[[client fetchPublicGistsWithPage:0] collect] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    [[[client fetchPublicGistsWithPage:3] collect] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

@end
