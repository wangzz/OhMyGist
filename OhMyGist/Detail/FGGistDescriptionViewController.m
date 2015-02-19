//
//  FGGistDescriptionViewController.m
//  OhMyGist
//
//  Created by wangzz on 15-2-5.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGGistDescriptionViewController.h"

@interface FGGistDescriptionViewController ()

@property (nonatomic, copy) NSString *gistDescription;

@end

@implementation FGGistDescriptionViewController

- (instancetype)initWithDescription:(NSString *)description
{
    if (self = [super init]) {
        _gistDescription = description;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"Description",);
    
    [self createLeftBarWithTitle:NSLocalizedString(@"Cancel",)];
    [self createRightBarWithTitle:NSLocalizedString(@"Save",)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIButton Action

- (void)onRightBarAction:(id)sender
{
    if (self.completionHandler) {
        self.completionHandler(self.gistDescription);
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)onLeftBarAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
