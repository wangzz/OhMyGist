//
//  FGAccountManager.m
//  OhMyGist
//
//  Created by wangzz on 15-1-29.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGAccountManager.h"
#import "OctoKit.h"
#import "FGError.h"
#import "NSUserDefaults+SecureAdditions.h"


#define KEY_USERNAME        @"KEY_USERNAME"
#define KEY_TOKEN           @"KEY_TOKEN"

@interface FGAccountManager ()

@property (nonatomic, strong) OCTClient *client;

@end

@implementation FGAccountManager

+ (instancetype)defaultManager
{
    static FGAccountManager *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


- (void)loginWithUserName:(NSString *)userName password:(NSString *)password completionBlock:(completionBlock)completionBlock
{
    OCTUser *user = [OCTUser userWithRawLogin:userName server:OCTServer.dotComServer];
    [[OCTClient signInAsUser:user password:password oneTimePassword:nil scopes:OCTClientAuthorizationScopesUser note:nil noteURL:nil fingerprint:nil] subscribeNext:^(OCTClient *authenticatedClient) {
        //Authentication was successful. Do something with the created client.
        self.client = authenticatedClient;
        [[NSUserDefaults standardUserDefaults] setSecretObject:self.client.user.name forKey:KEY_USERNAME];
        [[NSUserDefaults standardUserDefaults] setSecretObject:self.client.token forKey:KEY_TOKEN];

        completionBlock(authenticatedClient,nil);
    } error:^(NSError *error) {
        // Authentication failed.
        NSLog(@"%@",error);
        [self clearUserInfo];
        completionBlock(nil,[FGError errorWith:error]);
    }];
}

- (void)logoutWithCompletionBlock:(completionBlock)completionBlock
{
    [self clearUserInfo];
}

- (void)clearUserInfo
{
    // clear user name & token
    [[NSUserDefaults standardUserDefaults] setSecretObject:@"" forKey:KEY_USERNAME];
    [[NSUserDefaults standardUserDefaults] setSecretObject:@"" forKey:KEY_TOKEN];
}

- (OCTClient *)client
{
    if (self.client) {
        return self.client;
    }
    
    OCTClient *client = nil;
    NSString *userName = [[NSUserDefaults standardUserDefaults] secretStringForKey:KEY_USERNAME];
    NSString *token = [[NSUserDefaults standardUserDefaults] secretStringForKey:KEY_TOKEN];
    if (userName && token) {
        OCTUser *user = [OCTUser userWithRawLogin:userName server:OCTServer.dotComServer];
        client = [OCTClient authenticatedClientWithUser:user token:token];
    }
    
    return client;
}

@end
