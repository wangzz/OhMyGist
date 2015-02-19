//
//  FGGistEditViewController.m
//  OhMyGist
//
//  Created by wangzz on 15-2-5.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGGistEditViewController.h"

@interface FGGistEditViewController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong) OCTGist *gist;

@end

@implementation FGGistEditViewController

- (instancetype)initWithGist:(OCTGist *)gist
{
    if (self = [super init]) {
        _gist = gist;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (self.gist) {
        self.title = NSLocalizedString(@"Edit Gist",);
    } else {
        self.title = NSLocalizedString(@"Create Gist",);
    }
    
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
    
}

- (void)onLeftBarAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - UITableView Delegate




#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *commonCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (commonCell == nil) {
        commonCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    return commonCell;
}

@end
