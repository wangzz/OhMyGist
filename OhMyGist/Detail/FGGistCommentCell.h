//
//  FGGistCommentCell.h
//  OhMyGist
//
//  Created by wangzz on 15-2-2.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import <UIKit/UIKit.h>


#define CELL_BASE_HEIGHT      (66)


@class OCTGistComment;
@class RTLabel;
@protocol FGGistCommentCellDelegate <NSObject>

- (void)didSelectComment:(OCTGistComment *)comment;

@end


@interface FGGistCommentCell : UITableViewCell

@property (nonatomic, weak) id<FGGistCommentCellDelegate> delegate;

@property (nonatomic, strong) OCTGistComment *comment;

+ (RTLabel*)textLabel;

+ (NSString *)htmlStringWith:(NSString *)string;

@end
