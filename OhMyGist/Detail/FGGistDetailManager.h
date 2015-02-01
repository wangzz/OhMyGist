//
//  FGGistDetailManager.h
//  OhMyGist
//
//  Created by wangzz on 15/2/1.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FGAccountManager.h"

@interface FGGistDetailManager : NSObject


- (void)fetchDetailWithGist:(OCTGist *)gist completionBlock:(completionBlock)completionBlock;

- (void)cancelRequest;

@end
