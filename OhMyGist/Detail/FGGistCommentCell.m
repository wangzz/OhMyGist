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
#import "MMMarkdown.h"

@interface FGGistCommentCell ()

@property (nonatomic, strong) IBOutlet UIImageView *avatarImageView;

@property (nonatomic, strong) IBOutlet UIButton *nameButton;

@property (nonatomic, strong) IBOutlet UILabel *dateLabel;

@property (nonatomic, strong) IBOutlet UILabel *bodyLabel;

@property (nonatomic, strong) IBOutlet UIWebView *webView;

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
    
    [self.avatarImageView setImageWithURL:self.comment.userAvatar placeholderImage:nil];
    
    [self.nameButton setTitle:self.comment.userName forState:UIControlStateNormal];
    
    self.dateLabel.text = [self.comment.updatedDate stringFormat];
    
    NSError *err = nil;
    NSString *htmlString = [MMMarkdown HTMLStringWithMarkdown:_comment.body extensions:MMMarkdownExtensionsGitHubFlavored error:&err];
    if (err == nil) {
        [self.webView loadHTMLString:htmlString baseURL:nil];
    }
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

- (IBAction)onNameButtonAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(didSelectComment:)]) {
        [self.delegate didSelectComment:self.comment];
    }
}

@end
