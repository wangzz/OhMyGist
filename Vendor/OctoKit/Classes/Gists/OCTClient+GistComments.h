//
//  OCTClient+GistComments.h
//  OhMyGist
//
//  Created by wangzz on 15-2-2.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "OCTClient.h"

@class OCTGist;
@class OCTGistComment;
@interface OCTClient (GistComments)

- (RACSignal *)fetchCommentsWithGist:(OCTGist *)gist;

- (RACSignal *)addCommentWithGist:(OCTGist *)gist
                             body:(NSString *)body;

- (RACSignal *)editCommentWithGist:(OCTGist *)gist
                          comment:(OCTGistComment *)comment
                             body:(NSString *)body;

@end
