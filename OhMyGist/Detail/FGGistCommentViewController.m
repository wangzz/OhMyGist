//
//  FGGistCommentViewController.m
//  OhMyGist
//
//  Created by wangzz on 15-2-5.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGGistCommentViewController.h"
#import "FGAddCommentManager.h"
#import "SVProgressHUD.h"

@interface FGGistCommentViewController ()

@property (nonatomic, strong) FGAddCommentManager *manager;

@property (nonatomic, strong) OCTGist *gist;

@property (nonatomic, strong) OCTGistComment *comment;

@end

@implementation FGGistCommentViewController

- (instancetype)initWithGist:(OCTGist *)gist
{
    return [self initWithGist:gist comment:nil];
}

- (instancetype)initWithGist:(OCTGist *)gist comment:(OCTGistComment *)comment
{
    // load super class nib
    if (self = [super initWithNibName:@"FGEditViewController" bundle:[NSBundle mainBundle]]) {
        _manager = [[FGAddCommentManager alloc] init];
        _gist = gist;
        _comment = comment;
    }
    
    return self;
}

- (void)dealloc
{
    [_manager cancelRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (self.comment) {
        self.title = NSLocalizedString(@"Edit Comment",);
        self.textView.text = self.comment.body;
    } else {
        self.title = NSLocalizedString(@"New Comment",);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)disposeCommentWith:(id)object error:(FGError *)error
{
    if ([object isKindOfClass:[OCTGistComment class]] && error == nil) {
        [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Commit success!",)];
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    } else {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Something error, please try again later.",)];
    }
}

#pragma mark - UIButton Action

- (void)onRightBarAction:(id)sender
{    
    if (self.textView.text.length == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Warning",) message:NSLocalizedString(@"Input can not be empty!",) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",) otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Just waiting...",)];
    @weakify(self);
    if (self.comment) {
        [_manager editCommentWithGist:self.gist comment:self.comment body:self.textView.text completionBlock:^(id object, FGError *error) {
            @strongify(self);
            [self disposeCommentWith:object error:error];
        }];
    } else {
        [_manager addCommentWithGist:self.gist body:self.textView.text completionBlock:^(id object, FGError *error) {
            @strongify(self);
            [self disposeCommentWith:object error:error];
        }];
    }
}


@end
