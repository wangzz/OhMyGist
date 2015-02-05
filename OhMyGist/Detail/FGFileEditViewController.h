//
//  FGFileEditViewController.h
//  OhMyGist
//
//  Created by wangzz on 15-2-5.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGViewController.h"

@class OCTGistFile;
@interface FGFileEditViewController : FGViewController

- (instancetype)initWithGistFile:(OCTGistFile *)gistFile;

@end
