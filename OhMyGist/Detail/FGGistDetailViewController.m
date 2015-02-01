//
//  FGGistDetailViewController.m
//  OhMyGist
//
//  Created by wangzz on 15/2/1.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGGistDetailViewController.h"
#import "FGGistDetailManager.h"
#import "SVProgressHUD.h"

@interface FGGistDetailViewController ()
{
    FGGistDetailManager *_manager;
    OCTGist *_gist;
}

@end

@implementation FGGistDetailViewController

- (instancetype)initWithGist:(OCTGist *)gist
{
    if (self = [super init]) {
        _manager = [[FGGistDetailManager alloc] init];
        _gist = gist;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Detail";
    
    [self loadGistDetail];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadGistDetail
{
    
}

@end
