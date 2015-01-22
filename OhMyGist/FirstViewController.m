//
//  FirstViewController.m
//  OhMyGist
//
//  Created by wangzz on 15/1/14.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FirstViewController.h"
#import "OctoKit.h"
#import "FGDataManager.h"

static NSString * const OCTClientOneTimePasswordHeaderField = @"X-GitHub-OTP";
static NSString * const OCTClientOAuthScopesHeaderField = @"X-OAuth-Scopes";

@interface FirstViewController ()

@property (nonatomic, strong) NSURLSession  *session;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 100, 50)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginButtonAction:(id)sender
{
    [FGDataManager loginWithUserName:@"wangzz" password:@"victory2011" completionBlock:^(id object, FGError *error) {
        if (error == nil) {
//            [self fetchGistsWith:object];
//            [self fetchUserInfoWith:object];
//            [self fetchUserRepositoriesWith:object];
            [self fetchPublicGistsWith:object];
        }
    }];
}

- (void)fetchPublicGistsWith:(OCTClient *)client
{
    [FGDataManager fetchPublicGists:client completionBlock:^(id object, FGError *error) {
        NSLog(@"%@",object);
    }];
}

- (void)fetchGistsWith:(OCTClient *)client
{
    [FGDataManager fetchGists:client completionBlock:^(id object, FGError *error) {
        NSLog(@"%@",object);
    }];
}

- (void)fetchUserInfoWith:(OCTClient *)client
{
    [FGDataManager fetchUserInfo:client completionBlock:^(id object, FGError *error) {
        NSLog(@"%@",object);
    }];
}

- (void)fetchUserRepositoriesWith:(OCTClient *)client
{
    [FGDataManager fetchUserRepositories:client completionBlock:^(id object, FGError *error) {
        NSLog(@"%@",object);
    }];
}

@end
