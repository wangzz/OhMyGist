//
//  FGStarredGistsViewController.m
//  OhMyGist
//
//  Created by wangzz on 15-1-29.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGStarredGistsViewController.h"
#import "FGStarredGistsManager.h"

@interface FGStarredGistsViewController ()

@property (nonatomic, strong) FGStarredGistsManager *manager;

@end

@implementation FGStarredGistsViewController

- (instancetype)init
{
    if (self = [super init]) {
        _manager = [[FGStarredGistsManager alloc] init];
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
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"Starred",);;
    
    [self setEnableInfiniteScrolling:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Refresh/InfiniteScrolling

- (void)pullToRefresh
{
    [_manager fetchStarredGistsFirstPageWithCompletionBlock:^(id object, FGError *error) {
        if (error == nil && [object isKindOfClass:[NSArray class]]) {
            NSArray *objectArray = object;
            if (objectArray.count > 0) {
                self.gistsArray = [objectArray mutableCopy];
                [self.tableView reloadData];
            }
        } else if (error) {
            NSLog(@"%@",error);
        }
        
        // Finish refresh
        [self.refreshControl endRefreshing];
        if (self.gistsArray.count > 0 && (self.gistsArray.count%PER_PAGE_COUNTS == 0)) {
            [self setEnableInfiniteScrolling:YES];
        } else {
            [self setEnableInfiniteScrolling:NO];
        }
    }];
}

- (void)infiniteScrollingLoadMore
{
    [_manager fetchStarredGistsNextPageWithCompletionBlock:^(id object, FGError *error) {
        if (error == nil && [object isKindOfClass:[NSArray class]]) {
            NSArray *objectArray = object;
            if (objectArray.count > 0) {
                [self.gistsArray addObjectsFromArray:objectArray];
                [self.tableView reloadData];
            }
        } else if (error) {
            NSLog(@"%@",error);
        }
        
        [self.tableView.infiniteScrollingView stopAnimating];
        if (self.gistsArray.count > 0 && (self.gistsArray.count%PER_PAGE_COUNTS == 0)) {
            [self setEnableInfiniteScrolling:YES];
        } else {
            [self setEnableInfiniteScrolling:NO];
        }
    }];
}

#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 112;
}


@end
