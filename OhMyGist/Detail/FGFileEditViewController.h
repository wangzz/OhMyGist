//
//  FGFileEditViewController.h
//  OhMyGist
//
//  Created by wangzz on 15-2-5.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGEditViewController.h"

@class OCTGistFileEdit;
@interface FGFileEditViewController : FGEditViewController

@property (nonatomic, copy)  void (^completionHandler)(id object);;

- (instancetype)initWithGistFile:(OCTGistFileEdit *)fileEdit;

@end
