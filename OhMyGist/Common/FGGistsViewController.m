//
//  FGGistsViewController.m
//  OhMyGist
//
//  Created by wangzz on 15-1-29.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGGistsViewController.h"
#import "FGGistTableViewCell.h"
#import "UIViewController+RESideMenu.h"
#import "FGLoginViewController.h"
#import "FGAccountManager.h"
#import "OCTClient.h"
#import "FGGistDetailViewController.h"

@interface FGGistsViewController ()

@end

@implementation FGGistsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [leftButton setTitle:NSLocalizedString(@"Mine",) forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(presentLeftMenu:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    // Init tableView
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    
    @weakify(self);
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        @strongify(self);
        [self infiniteScrollingLoadMore];
    }];
    
    // Init refreshControl
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self
                            action:@selector(controlEventValueChanged:)
                  forControlEvents:UIControlEventValueChanged];
    [self beginRefreshingTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)beginRefreshingTableView
{
    [self.refreshControl beginRefreshing];
    [self.refreshControl sendActionsForControlEvents:UIControlEventValueChanged];
    if (self.tableView.contentOffset.y == 0) {
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^(void){
            self.tableView.contentOffset = CGPointMake(0, -self.refreshControl.frame.size.height);
        } completion:^(BOOL finished){
            NSLog(@"%d",finished);
        }];
    }
}

#pragma mark - UIButton Action

- (void)presentLeftMenu:(id)sender
{
    OCTClient *client = [[FGAccountManager defaultManager] client];
    if (!client.authenticated) {
        FGLoginViewController *loginController = [[FGLoginViewController alloc] init];
        [self presentViewController:loginController animated:YES completion:^{
            
        }];
        
        return;
    }
    
    [self presentLeftMenuViewController:sender];
}

#pragma mark - Refresh/InfiniteScrolling

- (void)controlEventValueChanged:(id)sender {
    if (self.refreshControl.refreshing) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(pullToRefresh) object:nil];
        
        [self performSelector:@selector(pullToRefresh) withObject:nil afterDelay:0];
    }
}

- (void)pullToRefresh
{
    
}

- (void)infiniteScrollingLoadMore
{
    
}

- (void)setEnableInfiniteScrolling:(BOOL)isEnable
{
    self.tableView.infiniteScrollingView.enabled = isEnable;
    self.tableView.showsInfiniteScrolling = isEnable;
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    OCTGist *gist = self.gistsArray[indexPath.row];
    FGGistDetailViewController *detailController = [[FGGistDetailViewController alloc] initWithGist:gist];
    [self.navigationController pushViewController:detailController animated:YES];
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.gistsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    FGGistTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"FGGistTableViewCell" owner:self options:nil].firstObject;
    }
    
    cell.gist = self.gistsArray[indexPath.row];
    
    return cell;
}



@end
