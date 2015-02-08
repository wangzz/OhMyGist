//
//  FGGistCommentViewController.m
//  OhMyGist
//
//  Created by wangzz on 15-2-5.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGGistCommentViewController.h"
#import "FGAddCommentManager.h"
#import "FGCommonDefine.h"

@interface FGGistCommentViewController ()

@property (nonatomic, strong) IBOutlet UITextView *textView;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *bottomConstraint;

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
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
        
        _manager = [[FGAddCommentManager alloc] init];
        _gist = gist;
        _comment = comment;
    }
    
    return self;
}

- (void)dealloc
{
    [_manager cancelRequest];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    
    if (IOS7_OR_LATER) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self createRightBarWithTitle:NSLocalizedString(@"Done",)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIButton Action

- (void)onRightBarAction:(id)sender
{
    NSLog(@"%s",__func__);
    
    if (self.textView.text.length == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Warning",) message:NSLocalizedString(@"Input can not be empty!",) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",) otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    @weakify(self);
    if (self.comment) {
        [_manager editCommentWithGist:self.gist comment:self.comment body:self.textView.text completionBlock:^(id object, FGError *error) {
            @strongify(self);
            NSLog(@"%@ %@",object,self);
        }];
    } else {
        [_manager addCommentWithGist:self.gist body:self.textView.text completionBlock:^(id object, FGError *error) {
            @strongify(self);
            NSLog(@"%@ %@",object,self);
        }];
    }
}

#pragma mark - Notification

- (void)keyboardWillShowNotification:(NSNotification *)notification
{
    NSDictionary*info=[notification userInfo];
    CGSize kbSize=[[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size;
    
    self.bottomConstraint.constant = kbSize.height;
    [self.view layoutIfNeeded];
}

@end