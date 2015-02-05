//
//  OCTClient+GistComments.m
//  OhMyGist
//
//  Created by wangzz on 15-2-2.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "OCTClient+GistComments.h"
#import "OCTClient+Private.h"
#import "OCTGist.h"
#import "RACSignal+OCTClientAdditions.h"
#import "ReactiveCocoa.h"
#import "OCTGistComment.h"

@implementation OCTClient (GistComments)

- (RACSignal *)fetchCommentsWithGist:(OCTGist *)gist {
    NSURLRequest *request = [self requestWithMethod:@"GET" path:[NSString stringWithFormat:@"gists/%@/comments",gist.objectID] parameters:nil notMatchingEtag:nil];
    return [[self enqueueRequest:request resultClass:OCTGistComment.class fetchAllPages:YES] oct_parsedResults];
}

- (RACSignal *)addCommentWithGist:(OCTGist *)gist
                             body:(NSString *)body {
    NSParameterAssert(gist != nil);
    NSParameterAssert(body != nil);
    
    NSURLRequest *request = [self requestWithMethod:@"POST" path:[NSString stringWithFormat:@"gists/%@/comments",gist.objectID] parameters:@{@"body":body} notMatchingEtag:nil];
    return [[self enqueueRequest:request resultClass:OCTGistComment.class] oct_parsedResults];
}

- (RACSignal *)editCommentWithGist:(OCTGist *)gist
                           comment:(OCTGistComment *)comment
                              body:(NSString *)body {
    NSParameterAssert(gist != nil);
    NSParameterAssert(comment != nil);
    NSParameterAssert(body != nil);
    
    NSURLRequest *request = [self requestWithMethod:@"PATCH" path:[NSString stringWithFormat:@"gists/%@/comments/%@",gist.objectID,comment.objectID] parameters:@{@"body":body} notMatchingEtag:nil];
    return [[self enqueueRequest:request resultClass:OCTGistComment.class] oct_parsedResults];
}

@end
