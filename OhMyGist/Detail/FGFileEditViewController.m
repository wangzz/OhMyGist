//
//  FGFileEditViewController.m
//  OhMyGist
//
//  Created by wangzz on 15-2-5.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGFileEditViewController.h"
#import "OCTGistFile.h"
#import "SVProgressHUD.h"
#import "Masonry.h"

@interface FGFileEditViewController ()

@property (nonatomic, strong) OCTGistFileEdit *gistFileEdit;

@property (nonatomic, strong) UITextField *nameTextField;

@end

@implementation FGFileEditViewController

- (instancetype)initWithGistFile:(OCTGistFileEdit *)fileEdit
{
    // load super class nib
    if (self = [super initWithNibName:@"FGEditViewController" bundle:[NSBundle mainBundle]]) {
        if (fileEdit) {
            _gistFileEdit = fileEdit;
        } else {
            _gistFileEdit = [[OCTGistFileEdit alloc] init];
        }
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (self.gistFileEdit) {
        self.title = NSLocalizedString(@"Edit File",);
    } else {
        self.title = NSLocalizedString(@"New File",);
    }
    
    _nameTextField = ({
        UITextField *nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 20)];
        nameTextField.backgroundColor = [UIColor lightGrayColor];
        nameTextField.placeholder = NSLocalizedString(@"Input file name",);
        if (self.gistFileEdit.filename.length > 0) {
            nameTextField.text = self.gistFileEdit.filename;
        }
        nameTextField;
        
    });
    [self.view addSubview:_nameTextField];
    
    [self.view removeConstraint:self.topConstraint];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameTextField.mas_bottom);
    }];
    self.textView.text = self.gistFileEdit.content;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIButton Action

- (void)onRightBarAction:(id)sender
{
    if (self.nameTextField.text.length == 0 || self.textView.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"Illegal input!",)];
        return;
    }
    
    self.gistFileEdit.filename = self.nameTextField.text;
    self.gistFileEdit.content = self.textView.text;
    
    if (self.completionHandler) {
        self.completionHandler(self.gistFileEdit);
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
