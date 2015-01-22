//
//  FGError.m
//  OhMyGist
//
//  Created by wangzz on 15-1-22.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGError.h"

@implementation FGError


+ (instancetype)errorWith:(NSError *)error
{
    if (error == nil || ![error isKindOfClass:[NSError class]]) {
        return nil;
    }
    
    FGError *fgError = [[[self class] alloc] init];
    fgError.code = error.code;
    fgError.desc = error.localizedDescription;
    return fgError;
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"%p code:%d desc:%@",self,_code,_desc];
}

@end
