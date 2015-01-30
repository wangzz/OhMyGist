//
//  FGGistsViewController.m
//  OhMyGist
//
//  Created by wangzz on 15-1-29.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGGistsViewController.h"
#import "FGGistTableViewCell.h"


@interface FGGistsViewController ()

@end

@implementation FGGistsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Init tableView
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    
    typeof(self) __weak weakSelf = self;
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf infiniteScrollingLoadMore];
    }];
    
    // Init refreshControl
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self
                            action:@selector(controlEventValueChanged:)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSLog(@"%s",__func__);
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
