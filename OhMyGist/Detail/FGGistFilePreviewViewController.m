//
//  FGGistFilePreviewViewController.m
//  OhMyGist
//
//  Created by wangzz on 15/2/19.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGGistFilePreviewViewController.h"
#import "OCTGistFile.h"
#import "SVProgressHUD.h"

@interface FGGistFilePreviewViewController ()

@property (nonatomic, strong) IBOutlet UIWebView *webView;

@property (nonatomic, strong) OCTGistFile *gistFile;

@end

@implementation FGGistFilePreviewViewController

- (instancetype)initWithGistFile:(OCTGistFile *)gistFile
{
    if (self = [super init]) {
        _gistFile = gistFile;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = self.gistFile.filename;
    
    NSURLRequest *request =[NSURLRequest requestWithURL:self.gistFile.rawURL];
    [self.webView loadRequest:request];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.webView stopLoading];
    self.webView.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Loading...",)];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [SVProgressHUD showErrorWithStatus:@"Loading failed"];
}

@end
