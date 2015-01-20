//
//  FirstViewController.m
//  OhMyGist
//
//  Created by wangzz on 15/1/14.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FirstViewController.h"
#import "FGNetworkClient.h"
#import "OctoKit.h"

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
    [self user:@"wangzz" password:@"victory2011"];
}

- (void)user:(NSString *)userName password:(NSString *)password
{
    OCTUser *user = [OCTUser userWithRawLogin:userName server:OCTServer.dotComServer];
    [[OCTClient
      signInAsUser:user password:password oneTimePassword:nil scopes:OCTClientAuthorizationScopesUser]
     subscribeNext:^(OCTClient *authenticatedClient) {
         // Authentication was successful. Do something with the created client.
         NSLog(@"%@",authenticatedClient);
     } error:^(NSError *error) {
         // Authentication failed.
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
