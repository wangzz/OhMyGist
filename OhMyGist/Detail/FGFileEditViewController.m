//
//  FGFileEditViewController.m
//  OhMyGist
//
//  Created by wangzz on 15-2-5.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGFileEditViewController.h"
#import "OCTGistFile.h"

@interface FGFileEditViewController ()

@property (nonatomic, strong) OCTGistFile *gistFile;

@end

@implementation FGFileEditViewController

- (instancetype)initWithGistFile:(OCTGistFile *)gistFile;
{
    if (self = [super init]) {
        _gistFile = gistFile;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (self.gistFile) {
        self.title = NSLocalizedString(@"Edit file",);
    } else {
        self.title = NSLocalizedString(@"Create file",);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
