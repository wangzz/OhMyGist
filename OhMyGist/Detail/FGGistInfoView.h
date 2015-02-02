//
//  FGGistInfoView.h
//  OhMyGist
//
//  Created by wangzz on 15-2-2.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OCTGist;
@class FGGistInfoView;

@protocol FGGistInfoViewDelegate <NSObject>

- (void)didSelectGist:(OCTGist *)gist;

@end


@interface FGGistInfoView : UIView

@property (nonatomic, weak) id<FGGistInfoViewDelegate> delegate;

@property (nonatomic, strong) OCTGist *gist;

- (void)updateFrame;

@end
