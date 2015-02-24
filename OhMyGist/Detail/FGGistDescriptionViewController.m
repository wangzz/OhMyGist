//
//  FGGistDescriptionViewController.m
//  OhMyGist
//
//  Created by wangzz on 15-2-5.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGGistDescriptionViewController.h"

@interface FGGistDescriptionViewController ()

@end

@implementation FGGistDescriptionViewController

- (instancetype)initWithDescription:(NSString *)description
{
    // load super class nib
    if (self = [super initWithNibName:@"FGEditViewController" bundle:[NSBundle mainBundle]]) {
        self.textView.text = description;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"Description",);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIButton Action

- (void)onRightBarAction:(id)sender
{
    if (self.completionHandler) {
        self.completionHandler(self.textView.text);
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
