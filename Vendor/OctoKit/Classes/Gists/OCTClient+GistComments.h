//
//  OCTClient+GistComments.h
//  OhMyGist
//
//  Created by wangzz on 15-2-2.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "OCTClient.h"

@class OCTGist;
@interface OCTClient (GistComments)

- (RACSignal *)fetchCommentsWithGist:(OCTGist *)gist;

@end
