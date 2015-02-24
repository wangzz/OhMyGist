//
//  FGEditViewController.h
//  OhMyGist
//
//  Created by wangzz on 15/2/24.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGViewController.h"

@interface FGEditViewController : FGViewController

@property (nonatomic, strong) IBOutlet UITextView *textView;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *topConstraint;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *bottomConstraint;

@end
