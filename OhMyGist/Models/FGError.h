//
//  FGError.h
//  OhMyGist
//
//  Created by wangzz on 15-1-22.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FGError : NSObject

@property (nonatomic) NSInteger code;

@property (nonatomic, copy) NSString *desc;

+ (instancetype)errorWith:(NSError *)error;

@end
