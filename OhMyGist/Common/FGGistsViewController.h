//
//  FGGistsViewController.h
//  OhMyGist
//
//  Created by wangzz on 15-1-29.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGViewController.h"
#import "UIScrollView+SVInfiniteScrolling.h"

@interface FGGistsViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *gistsArray;


- (void)pullToRefresh;

- (void)infiniteScrollingLoadMore;

- (void)setEnableInfiniteScrolling:(BOOL)isEnable;

@end
