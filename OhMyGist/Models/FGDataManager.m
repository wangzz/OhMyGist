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
    [[OCTClient
      signInAsUser:user password:password oneTimePassword:nil scopes:OCTClientAuthorizationScopesUser]
     subscribeNext:^(OCTClient *authenticatedClient) {
         // Authentication was successful. Do something with the created client.
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
    NSMutableArray *gistsArray = [NSMutableArray array];
    [[client fetchGists] subscribeNext:^(id x) {
        if ([x isKindOfClass:[OCTGist class]]) {
            OCTGist *gist = x;
            id value = gist.files.allValues.firstObject;
            if ([value isKindOfClass:[OCTGistFile class]]) {
                [gistsArray addObject:value];
            }
        }
    } error:^(NSError *error) {
        NSLog(@"%@",error);
        if (completionBlock) {
            completionBlock(nil,[FGError errorWith:error]);
        }
    } completed:^{
        NSLog(@"completed");
        if (completionBlock) {
            completionBlock(gistsArray,nil);
        }
    }];
}


@end
