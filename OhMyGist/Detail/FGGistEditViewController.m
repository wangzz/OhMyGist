//
//  FGGistEditViewController.m
//  OhMyGist
//
//  Created by wangzz on 15-2-5.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGGistEditViewController.h"
#import "FGGistDescriptionViewController.h"
#import "FGNavigationController.h"
#import "OCTGist.h"
#import "OCTGistFile.h"

@interface FGGistEditViewController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong) OCTGist *gist;

@property (nonatomic, strong) NSMutableArray *filesArray;   // Data source to show

// Changes property of gist

@property (nonatomic, strong) NSMutableArray *filesToAdd;

@property (nonatomic, strong) NSMutableArray *filesToModify;

@property (nonatomic, copy) NSString *fileDescription;

@end

@implementation FGGistEditViewController

- (instancetype)initWithGist:(OCTGist *)gist
{
    if (self = [super init]) {
        _gist = gist;
        _fileDescription = _gist.gistDescription;
        _filesArray = [_gist.files.allValues mutableCopy];
        _filesToAdd = [[NSMutableArray alloc] init];
        _filesToModify = [[NSMutableArray alloc] init];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        @weakify(self);
        FGGistDescriptionViewController *descriptionController = [[FGGistDescriptionViewController alloc] initWithDescription:self.gist.gistDescription];
        descriptionController.completionHandler = ^(id object) {
            @strongify(self);
            if ([object isKindOfClass:[NSString class]]) {
                self.fileDescription = object;
                [self.tableView reloadData];
            }
        };
        
        FGNavigationController *navigationController = [[FGNavigationController alloc] initWithRootViewController:descriptionController];
        [self presentViewController:navigationController animated:YES completion:^{
            
        }];
        
        
    } else if (indexPath.section == 1) {
        
    }
}

#pragma mark - UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return NSLocalizedString(@"Description",);
    } else if (section == 1) {
        return NSLocalizedString(@"Files",);
    } else if (section == 2) {
        return NSLocalizedString(@"Permission",);
    }
    
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0) {
        return 1;
    } else if (sectionIndex == 1) {
        return self.filesArray.count+1;
    } else if (sectionIndex == 2) {
        return 1;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *commonCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (commonCell == nil) {
        commonCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (indexPath.section == 0) {
        if (self.fileDescription) {
            commonCell.textLabel.text = self.fileDescription;
        } else {
            commonCell.textLabel.text = NSLocalizedString(@"Add description...",);
        }
    } else if (indexPath.section == 1) {
        if (self.filesArray.count == indexPath.row) {
            commonCell.textLabel.text = NSLocalizedString(@"Add New File",);
        } else if (self.filesArray.count > 0) {
            OCTGistFile *gistFile = self.filesArray[indexPath.row];
            commonCell.textLabel.text = gistFile.filename;
            commonCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)gistFile.size];
        }
    } else if (indexPath.section == 2) {
        commonCell.textLabel.text = @"YES";
    }
    
    return commonCell;
}

@end
