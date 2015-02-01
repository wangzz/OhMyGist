//
//  FGMenu.h
//  OhMyGist
//
//  Created by wangzz on 15/1/31.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FGMenu : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *subClass;

@property (nonatomic) BOOL needAuthentication;

- (instancetype)initWithTitle:(NSString *)title image:(NSString *)image subClass:(NSString *)subClass;


@end
