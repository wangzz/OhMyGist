//
//  FGGistDescriptionViewController.h
//  OhMyGist
//
//  Created by wangzz on 15-2-5.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGEditViewController.h"

@interface FGGistDescriptionViewController : FGEditViewController

- (instancetype)initWithDescription:(NSString *)description;

@property (nonatomic, copy)  void (^completionHandler)(id object);;

@end
