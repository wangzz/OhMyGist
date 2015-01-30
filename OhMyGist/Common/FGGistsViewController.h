//
//  FGGistsViewController.h
//  OhMyGist
//
//  Created by wangzz on 15-1-29.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGViewController.h"

@interface FGGistsViewController : FGViewController

@property (nonatomic, readonly, strong) UITableView   *tableView;

@property (nonatomic, strong) NSArray *gistsArray;

@end
