//
//  FGAccountViewController.m
//  OhMyGist
//
//  Created by wangzz on 15-1-29.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGAccountViewController.h"
#import "UIViewController+RESideMenu.h"
#import "UIImageView+AFNetworking.h"
#import "SVProgressHUD.h"
#import "FGAccountManager.h"

@interface FGAccountViewController ()

@property (nonatomic, strong) FGAccountManager *manager;

@property (nonatomic, strong) OCTUser *user;

@property (nonatomic, strong) IBOutlet UIImageView  *avatarImageView;

@property (nonatomic, strong) IBOutlet UILabel  *nameLabel;

@property (nonatomic, strong) IBOutlet UILabel  *infoLabel;

@end

@implementation FGAccountViewController

- (instancetype)init
{
    if (self = [super init]) {
        _manager = [[FGAccountManager alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"Profile",);
    if (IOS7_OR_LATER) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [leftButton setTitle:NSLocalizedString(@"Mine",) forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    [self loadInfoData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadInfoData
{
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Loading...",) maskType:SVProgressHUDMaskTypeGradient];
    @weakify(self);
    [_manager fetchUserInfoWithCompletionBlock:^(id object, FGError *error) {
        [SVProgressHUD dismiss];
        @strongify(self);
        if (error == nil && [object isKindOfClass:[OCTUser class]]) {
            self.user = object;
            [self loadInfoView];
        } else {
        }
    }];
}

- (void)loadInfoView
{
    self.title = self.user.login;
    
    [self.avatarImageView setImageWithURL:self.user.avatarURL placeholderImage:nil];
    self.nameLabel.text = self.user.name;
    self.infoLabel.text = [self infoString];
}

- (NSString *)infoString
{
    if (self.user.location.length > 0 && self.user.company.length > 0) {
        return [NSString stringWithFormat:@"%@,%@",self.user.company,self.user.location];
    } else if (self.user.location.length == 0 && self.user.company.length > 0) {
        return self.user.company;
    } else if (self.user.location.length > 0 && self.user.company.length == 0) {
        return self.user.location;
    }
    
    return nil;
}

@end
