//
//  OCTGistComment.h
//  OhMyGist
//
//  Created by wangzz on 15-2-2.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "MTLModel.h"
#import "OCTObject.h"

@interface OCTGistComment : OCTObject

// The body to the comment.
@property (nonatomic, copy, readonly) NSString *body;

// The user of the comment.
//@property (nonatomic, copy, readonly) NSDictionary *user;

// A direct URL to the comment.
@property (nonatomic, copy, readonly) NSURL *url;

// The created date of the comment.
@property (nonatomic, copy, readonly) NSDate *createdDate;

// The updated date of the comment.
@property (nonatomic, copy, readonly) NSDate *updatedDate;

// The owner name for ths comment.
@property (nonatomic, copy, readonly) NSString *userName;

// The owner avatar for ths comment.
@property (nonatomic, copy, readonly) NSURL *userAvatar;

@end
