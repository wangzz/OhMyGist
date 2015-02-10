//
//  FGPersonalGistsViewController.m
//  OhMyGist
//
//  Created by wangzz on 15-1-29.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGPersonalGistsViewController.h"
#import "FGPersonalGistsManager.h"


@interface FGPersonalGistsViewController ()

@property (nonatomic, strong) FGPersonalGistsManager *manager;

@end

@implementation FGPersonalGistsViewController

- (instancetype)init
{
    if (self = [super init]) {
        _manager = [[FGPersonalGistsManager alloc] init];
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
    
    self.title = NSLocalizedString(@"Personal",);;
    
    [self setEnableInfiniteScrolling:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Refresh/InfiniteScrolling

- (void)pullToRefresh
{
    @weakify(self);
    [_manager fetchPersonalGistsFirstPageWithCompletionBlock:^(id object, FGError *error) {
        @strongify(self);
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
    @weakify(self);
    [_manager fetchPersonalGistsNextPageWithCompletionBlock:^(id object, FGError *error) {
        @strongify(self);
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

#pragma mark - UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 112;
}


@end
