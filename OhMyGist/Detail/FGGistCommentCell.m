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
#import "RTLabel.h"

@interface FGGistCommentCell () <UIWebViewDelegate>

@property (nonatomic, strong) IBOutlet UIImageView *avatarImageView;

@property (nonatomic, strong) IBOutlet UIButton *nameButton;

@property (nonatomic, strong) IBOutlet UILabel *dateLabel;

@property (nonatomic, strong) IBOutlet RTLabel *bodyLabel;

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
    
    [self.bodyLabel setText:[[self class] htmlStringWith:self.comment.body]];
    
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

+ (NSString *)htmlStringWith:(NSString *)string
{
    NSError *err = nil;
    NSString *htmlString = [MMMarkdown HTMLStringWithMarkdown:string extensions:MMMarkdownExtensionsGitHubFlavored error:&err];
    if (err == nil) {
        return htmlString;
    }
    
    return nil;
}

+ (RTLabel*)textLabel
{
    RTLabel *label = [[RTLabel alloc] initWithFrame:CGRectMake(10,10,300,100)];
    //[label setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20]];
    [label setParagraphReplacement:@""];
    return label;
}

@end
