//
//  FGLoginViewController.m
//  OhMyGist
//
//  Created by wangzz on 15-1-29.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGLoginViewController.h"
#import "FGAccountManager.h"
#import "OctoKit.h"
#import "SVProgressHUD.h"

@interface FGLoginViewController ()

@property (nonatomic, strong) IBOutlet UITextField  *nameTextField;
@property (nonatomic, strong) IBOutlet UITextField  *passwordTextField;

@end

@implementation FGLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 80, 30)];
    [leftButton setTitle:NSLocalizedString(@"Dismiss",) forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(onLeftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)inputCheck
{
    if (self.nameTextField.text.length == 0 || self.passwordTextField.text.length == 0) {
        return NO;
    }
    
    return YES;
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - UIButton Action

- (IBAction)onLoginButtonAction:(id)sender
{
    if ([self inputCheck]) {
        @weakify(self);
        [SVProgressHUD showWithStatus:NSLocalizedString(@"Login...",)];
        [[FGAccountManager defaultManager] loginWithUserName:self.nameTextField.text password:self.passwordTextField.text completionBlock:^(id object, FGError *error) {
            [SVProgressHUD dismiss];
            @strongify(self);
            if (error == nil && [[FGAccountManager defaultManager] client].isAuthenticated) {
                [self dismiss];
            } else {
                NSLog(@"%@",error);
                [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Try again",) maskType:SVProgressHUDMaskTypeBlack];
            }
        }];
    } else {
        NSLog(@"input invalid");
    }
}

- (void)onLeftButtonAction:(id)sender
{
    [self dismiss];
}

@end
