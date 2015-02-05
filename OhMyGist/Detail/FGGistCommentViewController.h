//
//  FGGistCommentViewController.h
//  OhMyGist
//
//  Created by wangzz on 15-2-5.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGViewController.h"

@class OCTGist;
@class OCTGistComment;
@interface FGGistCommentViewController : FGViewController

- (instancetype)initWithGist:(OCTGist *)gist;

- (instancetype)initWithGist:(OCTGist *)gist comment:(OCTGistComment *)comment;

@end
