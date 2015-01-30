//
//  FGAllGistsViewController.m
//  OhMyGist
//
//  Created by wangzz on 15-1-29.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGAllGistsViewController.h"
#import "FGAllGistsManager.h"

@interface FGAllGistsViewController ()

@property (nonatomic, strong) FGAllGistsManager *manager;

@end

@implementation FGAllGistsViewController

- (instancetype)init
{
    if (self = [super init]) {
        _manager = [[FGAllGistsManager alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_manager fetchAllGistsFirstPageWithCompletionBlock:^(id object, FGError *error) {
        if (error == nil && [object isKindOfClass:[NSArray class]]) {
            self.gistsArray = object;
            [self.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
