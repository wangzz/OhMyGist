//
//  FGGistDetailViewController.m
//  OhMyGist
//
//  Created by wangzz on 15/2/1.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGGistDetailViewController.h"
#import "FGGistDetailManager.h"
#import "SVProgressHUD.h"
#import "FGGistInfoView.h"
#import "FGGistCommentCell.h"
#import "FGTitleTableViewCell.h"


#define HEIGHT_TABLEVIEW_SECTION    30

@interface FGGistDetailViewController () <UITableViewDelegate,UITableViewDataSource,FGGistInfoViewDelegate>
{
    FGGistDetailManager *_manager;
    OCTGist *_gist;
}

@property (nonatomic, strong) IBOutlet UITableView  *tableView;

@property (nonatomic, strong) FGGistInfoView   *headerView;

@property (nonatomic, strong) NSArray *commentsArray;

@end

@implementation FGGistDetailViewController

- (instancetype)initWithGist:(OCTGist *)gist
{
    if (self = [super init]) {
        _manager = [[FGGistDetailManager alloc] init];
        _gist = gist;
    }
    
    return self;
}

- (void)dealloc
{
    [_manager cancelRequest];
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Detail";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.headerView = ({
        FGGistInfoView *infoView = [[FGGistInfoView alloc] init];
        infoView.gist = _gist;
        infoView.delegate = self;
        [infoView updateFrame];
        infoView;
    });
    self.tableView.tableHeaderView = self.headerView;
    
    UIView *footerView = ({
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
        UIButton *footerButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 15, self.view.frame.size.width-40, 40)];
        [footerButton setTitle:NSLocalizedString(@"Add Comment",) forState:UIControlStateNormal];
        footerButton.backgroundColor = [UIColor redColor];
        [footerButton addTarget:self action:@selector(onAddCommentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:footerButton];
        footerView;
    });
    self.tableView.tableFooterView = footerView;
    
    [self loadGistComments];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadGistComments
{
    [_manager fetchCommentsWithGist:_gist completionBlock:^(id object, FGError *error) {
        if (error == nil && [object isKindOfClass:[NSArray class]]) {
            self.commentsArray = object;
            [self.tableView reloadData];
        } else if (error) {
            NSLog(@"%@",error);
        }
    }];
}


#pragma mark - UIButton Action

- (void)didSelectGist:(OCTGist *)gist
{
    NSLog(@"%s",__func__);
}

- (void)onAddCommentButtonAction:(id)sender
{
    NSLog(@"%s",__func__);
}

#pragma mark - UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HEIGHT_TABLEVIEW_SECTION;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, HEIGHT_TABLEVIEW_SECTION)];
    UILabel *sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, HEIGHT_TABLEVIEW_SECTION-15, self.view.frame.size.width-20, 15)];
    
    if (section == 0) {
        sectionLabel.text = @"FILES";
    } else if (section == 1) {
        sectionLabel.text = @"COMMENTS";
    }
    [sectionView addSubview:sectionLabel];
    return sectionView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    NSInteger rowCount = 0;
    if (sectionIndex == 0) {
        rowCount = (_gist.files.allValues.count==0)?1:_gist.files.allValues.count;
    } else if (sectionIndex == 1) {
        rowCount = (self.commentsArray.count==0)?1:self.commentsArray.count;
    }
    
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *commonCell = nil;
    if (indexPath.section == 1 && self.commentsArray.count > 0) {
        static NSString *cellIdentifier = @"FGGistCommentCell";
        FGGistCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"FGGistCommentCell" owner:self options:nil].firstObject;
        }
        
        cell.comment = self.commentsArray[indexPath.row];
        commonCell = cell;
    } else {
        static NSString *cellIdentifier = @"FGTitleTableViewCell";
        FGTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"FGTitleTableViewCell" owner:self options:nil].firstObject;
        }
        
        cell.showAccess = NO;
        if (indexPath.section == 0) {
            if (_gist.files.allValues.count == 0) {
                cell.title = NSLocalizedString(@"No Files",);
            } else {
                cell.showAccess = YES;
                cell.title = _gist.files.allKeys[indexPath.row];
            }
        } else if (indexPath.section == 1 && self.commentsArray.count == 0) {
            cell.title = NSLocalizedString(@"No Comments",);
        }
        
        commonCell = cell;
    }
    
    return commonCell;
}


@end
