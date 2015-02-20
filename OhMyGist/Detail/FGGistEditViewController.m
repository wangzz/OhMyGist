//
//  FGGistEditViewController.m
//  OhMyGist
//
//  Created by wangzz on 15-2-5.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGGistEditViewController.h"
#import "FGGistDescriptionViewController.h"
#import "FGFileEditViewController.h"
#import "FGNavigationController.h"
#import "OCTGist.h"
#import "OCTGistFile.h"
#import "NSString+Format.h"
#import "FGGistEditManager.h"
#import "SVProgressHUD.h"

@interface FGGistEditViewController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong) FGGistEditManager *manager;

@property (nonatomic, strong) OCTGist *gist;

@property (nonatomic, strong) NSMutableArray *filesArray;   // Data source to show

// Changes property of gist

@property (nonatomic, strong) NSMutableArray *filesToAdd;

@property (nonatomic, strong) NSMutableArray *filesToModify;

@property (nonatomic, copy) NSString *fileDescription;

@property (nonatomic) BOOL isPublic;

@end

@implementation FGGistEditViewController

- (instancetype)initWithGist:(OCTGist *)gist
{
    if (self = [super init]) {
        _gist = gist;
        _filesArray = [_gist.files.allValues mutableCopy];
        _filesToAdd = [[NSMutableArray alloc] init];
        _filesToModify = [[NSMutableArray alloc] init];
        _isPublic = _gist.isPublic;
        _fileDescription = _gist.gistDescription;
        
        _manager = [[FGGistEditManager alloc] init];
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

- (void)dealloc
{
    [_manager cancelRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (OCTGistEdit *)gistEdit
{
    OCTGistEdit *edit = [[OCTGistEdit alloc] init];
    edit.filesToAdd = self.filesToAdd;
    
    if (self.filesToModify.count > 0) {
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        for (OCTGistFileEdit *fileEdit in self.filesToModify) {
            dictionary[fileEdit.filename] = fileEdit;
        }
        edit.filesToModify = dictionary;
    }
    
    edit.publicGist = self.isPublic;
    
    return edit;
}

- (BOOL)isNeedSaveChange
{
    if (self.fileDescription.length > 0 && ![self.gist.gistDescription isEqualToString:self.fileDescription]) {
        return YES;
    }
    
    if (self.gist.isPublic != self.isPublic) {
        return YES;
    }
    
    if (self.filesToAdd.count > 0 || self.filesToModify.count > 0) {
        return YES;
    }
    
    return NO;
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - UIButton Action

- (void)onRightBarAction:(id)sender
{
    if ([self isNeedSaveChange]) {
        @weakify(self);
        if (self.gist) {
            [SVProgressHUD showWithStatus:NSLocalizedString(@"Saving...",)];
            [self.manager editGistWithEdit:[self gistEdit] gist:self.gist completionBlock:^(id object, FGError *error) {
                @strongify(self);
                if (object && error == nil) {
                    [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Save successed",)];
                    [self dismiss];
                } else {
                    [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Save failed, please try again later",)];
                }
            }];
        } else {
            [SVProgressHUD showWithStatus:NSLocalizedString(@"Creating...",)];
            [self.manager createGistWithEdit:[self gistEdit] completionBlock:^(id object, FGError *error) {
                @strongify(self);
                if (object && error == nil) {
                    [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Create successed",)];
                    [self dismiss];
                } else {
                    [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Create failed, please try again later",)];
                }
            }];
        }
    } else {
        [self dismiss];
    }
}

- (void)onLeftBarAction:(id)sender
{
    [self dismiss];
}

- (void)onSwitchChangedAction:(id)sender
{
    self.isPublic = ((UISwitch *)sender).isOn;
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
        OCTGistFile *file = nil;
        if (self.filesArray.count != indexPath.row) {
            file = self.filesArray[indexPath.row];
        }
        
        FGFileEditViewController *fileEditController = [[FGFileEditViewController alloc] initWithGistFile:file];
        FGNavigationController *navigationController = [[FGNavigationController alloc] initWithRootViewController:fileEditController];
        [self presentViewController:navigationController animated:YES completion:^{
            
        }];
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
    UITableViewCell *commonCell = nil;
    if (indexPath.section == 2) {
        commonCell = [tableView dequeueReusableCellWithIdentifier:@"cellWithSwitchView"];
        if (commonCell == nil) {
            commonCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellWithSwitchView"];
            commonCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
            commonCell.accessoryView = switchView;
            [switchView addTarget:self action:@selector(onSwitchChangedAction:) forControlEvents:UIControlEventValueChanged];
        }
    } else {
        commonCell = [tableView dequeueReusableCellWithIdentifier:@"cellWithIndicator"];
        if (commonCell == nil) {
            commonCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellWithIndicator"];
            commonCell.selectionStyle = UITableViewCellSelectionStyleNone;
            commonCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
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
            commonCell.detailTextLabel.text = [NSString stringFromBytes:gistFile.size];
        }
    } else if (indexPath.section == 2) {
        UISwitch *switchView = (UISwitch *)commonCell.accessoryView;
        [switchView setOn:self.isPublic];

        commonCell.textLabel.text = NSLocalizedString(@"Is Public",);
    }
    
    return commonCell;
}

@end
