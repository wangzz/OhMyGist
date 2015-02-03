//
//  FGSettingViewController.m
//  OhMyGist
//
//  Created by wangzz on 15-1-29.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGSettingViewController.h"
#import "UIViewController+RESideMenu.h"

@interface FGSettingViewController ()

@end

@implementation FGSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"Setting",);
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [leftButton setTitle:NSLocalizedString(@"Mine",) forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
            
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
