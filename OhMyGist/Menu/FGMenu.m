//
//  FGMenu.m
//  OhMyGist
//
//  Created by wangzz on 15/1/31.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGMenu.h"

@implementation FGMenu

- (instancetype)initWithTitle:(NSString *)title image:(NSString *)image subClass:(NSString *)subClass{
    if (self = [super init]) {
        _title = title;
        _image = image;
        _subClass = subClass;
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%p title:%@, image:%@, subClass:%@",self,_title,_image,_subClass];
}

@end
