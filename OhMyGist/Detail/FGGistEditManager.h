//
//  FGGistEditManager.h
//  OhMyGist
//
//  Created by wangzz on 15/2/20.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FGAccountManager.h"

@interface FGGistEditManager : NSObject

- (void)createGistWithEdit:(OCTGistEdit *)edit completionBlock:(completionBlock)completionBlock;

- (void)editGistWithEdit:(OCTGistEdit *)edit gist:(OCTGist *)gist completionBlock:(completionBlock)completionBlock;

- (void)cancelRequest;

- (void)fetchFileContentWith:(OCTGist *)gist completionBlock:(completionBlock)completionBlock;

@end
