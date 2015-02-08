//
//  FGAccountManager.m
//  OhMyGist
//
//  Created by wangzz on 15-1-29.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGAccountManager.h"
#import "NSUserDefaults+SecureAdditions.h"


#define KEY_USERNAME        @"KEY_USERNAME"
#define KEY_TOKEN           @"KEY_TOKEN"

@interface FGAccountManager ()

@property (nonatomic, strong) OCTClient *currentClient;

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
    [[[OCTClient signInAsUser:user password:password oneTimePassword:nil scopes:(OCTClientAuthorizationScopesUser|OCTClientAuthorizationScopesGist) note:nil noteURL:nil fingerprint:nil] deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(OCTClient *authenticatedClient) {
        //Authentication was successful. Do something with the created client.
        self.currentClient = authenticatedClient;
        [[NSUserDefaults standardUserDefaults] setSecretObject:self.currentClient.user.rawLogin forKey:KEY_USERNAME];
        [[NSUserDefaults standardUserDefaults] setSecretObject:self.currentClient.token forKey:KEY_TOKEN];
        completionBlock(authenticatedClient,nil);
        
    } error:^(NSError *error) {
        // Authentication failed.
        [self clearUserInfo];
        completionBlock(nil,[FGError errorWith:error]);
    }];
}

- (void)logoutWithCompletionBlock:(completionBlock)completionBlock
{
    [self clearUserInfo];
}

- (void)fetchUserInfoWithCompletionBlock:(completionBlock)completionBlock
{
    [[[self.client fetchUserInfo] deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(id x) {
        NSLog(@"%@",x);
        completionBlock(x,nil);
    } error:^(NSError *error) {
        NSLog(@"%@",error);
        completionBlock(nil,[FGError errorWith:error]);
    }];
}



- (void)clearUserInfo
{
    // clear user name & token
    [[NSUserDefaults standardUserDefaults] setSecretObject:@"" forKey:KEY_USERNAME];
    [[NSUserDefaults standardUserDefaults] setSecretObject:@"" forKey:KEY_TOKEN];
}

- (OCTClient *)client
{
    if (self.currentClient) {
        return self.currentClient;
    }
    
    OCTClient *client = nil;
    NSString *userName = [[NSUserDefaults standardUserDefaults] secretStringForKey:KEY_USERNAME];
    NSString *token = [[NSUserDefaults standardUserDefaults] secretStringForKey:KEY_TOKEN];
    if (userName.length > 0) {
        OCTUser *user = [OCTUser userWithRawLogin:userName server:OCTServer.dotComServer];
        if (token.length > 0) {
            client = [OCTClient authenticatedClientWithUser:user token:token];
        } else {
            client = [OCTClient unauthenticatedClientWithUser:user];
        }
    } else {
        client = [[OCTClient alloc] initWithServer:OCTServer.dotComServer];
    }
    
    self.currentClient = client;
    
    return client;
}

@end
