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
    return @[[[FGMenu alloc] initWithTitle:NSLocalizedString(@"Mine",) image:@"" subClass:@"FGAccountViewController" needAuthentication:YES],
             [[FGMenu alloc] initWithTitle:NSLocalizedString(@"All",) image:@"" subClass:@"FGAllGistsViewController" needAuthentication:NO],
             [[FGMenu alloc] initWithTitle:NSLocalizedString(@"Personal",) image:@"" subClass:@"FGPersonalGistsViewController" needAuthentication:YES],
             [[FGMenu alloc] initWithTitle:NSLocalizedString(@"Starred",) image:@"" subClass:@"FGStarredGistsViewController" needAuthentication:YES],
             [[FGMenu alloc] initWithTitle:NSLocalizedString(@"Forked",) image:@"" subClass:@"FGForkedGistsViewController" needAuthentication:YES],
             [[FGMenu alloc] initWithTitle:NSLocalizedString(@"Setting",) image:@"" subClass:@"FGSettingViewController" needAuthentication:NO]];
}

@end
