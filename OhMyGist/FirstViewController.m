//
//  FirstViewController.m
//  OhMyGist
//
//  Created by wangzz on 15/1/14.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FirstViewController.h"
#import "FGNetworkClient.h"

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

- (void)getlist
{
    [[FGNetworkClient sharedClient] GET:@"/gists/public" parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"%@",JSON);
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)loginButtonAction:(id)sender
{
    [self user:@"wangzz" password:@"victory2011"];
}

- (void)createAuthorizations
{
    NSDictionary *parameters = @{@"note":@"admin script",@"scopes":@[@"public_repo"]};
    [[FGNetworkClient sharedClient] POST:@"/authorizations" parameters:parameters success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"%@",JSON);
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)user:(NSString *)userName password:(NSString *)password
{
    [[FGNetworkClient sharedClient] POST:@"/user" parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"%@",JSON);
        [self createAuthorizations];
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)signIn:(NSString *)userName password:(NSString *)password
{
    NSString *requestString = @"https://api.github.com/user";
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    NSData *userPasswordData = [[NSString stringWithFormat:@"%@:%@", userName, password] dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64EncodedCredential = [userPasswordData base64EncodedStringWithOptions:0];
    NSString *authString = [NSString stringWithFormat:@"Basic %@", base64EncodedCredential];
    
    NSURLSessionConfiguration *sessionConfig=[NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfig.HTTPAdditionalHeaders=@{@"Authorization":authString};
    
    self.session=[NSURLSession sessionWithConfiguration:sessionConfig];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@", jsonObject);
        
        
    }];
    
    [dataTask resume];
}


@end
