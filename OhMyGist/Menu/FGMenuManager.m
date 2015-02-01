//
//  FGMenuManager.m
//  OhMyGist
//
//  Created by wangzz on 15/1/31.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGMenuManager.h"
#import "FGMenu.h"

@implementation FGMenuManager

- (NSArray *)menuItems
{
    return @[[[FGMenu alloc] initWithTitle:NSLocalizedString(@"Mine",) image:@"" subClass:@"FGAccountViewController"],
             [[FGMenu alloc] initWithTitle:NSLocalizedString(@"All",) image:@"" subClass:@"FGAllGistsViewController"],
             [[FGMenu alloc] initWithTitle:NSLocalizedString(@"Personal",) image:@"" subClass:@"FGPersonalGistsViewController"],
             [[FGMenu alloc] initWithTitle:NSLocalizedString(@"Starred",) image:@"" subClass:@"FGStarredGistsViewController"],
             [[FGMenu alloc] initWithTitle:NSLocalizedString(@"Forked",) image:@"" subClass:@"FGForkedGistsViewController"],
             [[FGMenu alloc] initWithTitle:NSLocalizedString(@"Setting",) image:@"" subClass:@"FGSettingViewController"]];
}

@end
