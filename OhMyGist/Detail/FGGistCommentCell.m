//
//  FGGistCommentCell.m
//  OhMyGist
//
//  Created by wangzz on 15-2-2.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGGistCommentCell.h"
#import "OCTGistComment.h"
#import "UIImageView+AFNetworking.h"
#import "NSDate+FormatString.h"

@interface FGGistCommentCell ()

@property (nonatomic, strong) IBOutlet UIImageView *avatarImageView;

@property (nonatomic, strong) IBOutlet UIButton *nameButton;

@property (nonatomic, strong) IBOutlet UILabel *dateLabel;

@property (nonatomic, strong) IBOutlet UILabel *bodyLabel;

@end

@implementation FGGistCommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setComment:(OCTGistComment *)comment
{
    _comment = comment;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.avatarImageView setImageWithURL:self.comment.userAvatar placeholderImage:nil];
    
    [self.nameButton setTitle:self.comment.userName forState:UIControlStateNormal];
    
    self.dateLabel.text = [self.comment.updatedDate stringFormat];
    
    self.bodyLabel.text = _comment.body;
}

- (IBAction)onNameButtonAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(didSelectComment:)]) {
        [self.delegate didSelectComment:self.comment];
    }
}

@end
