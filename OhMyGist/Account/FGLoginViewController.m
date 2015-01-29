//
//  FGLoginViewController.m
//  OhMyGist
//
//  Created by wangzz on 15-1-29.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGLoginViewController.h"
#import "FGAccountManager.h"

@interface FGLoginViewController ()

@property (nonatomic, strong) IBOutlet UITextField  *nameTextField;
@property (nonatomic, strong) IBOutlet UITextField  *passwordTextField;

@end

@implementation FGLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)inputCheck
{
    
    return YES;
}

- (IBAction)onLoginButtonAction:(id)sender
{
    if ([self inputCheck]) {
        [[FGAccountManager defaultManager] loginWithUserName:self.nameTextField.text password:self.passwordTextField.text completionBlock:^(id object, FGError *error) {
            NSLog(@"");
        }];
    }
}

@end
