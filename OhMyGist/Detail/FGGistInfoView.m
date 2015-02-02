//
//  FGGistInfoView.m
//  OhMyGist
//
//  Created by wangzz on 15-2-2.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGGistInfoView.h"
#import "UIImageView+AFNetworking.h"
#import "OctoKit.h"
#import "FGAccountManager.h"
#import "NSDate+FormatString.h"

@interface FGGistInfoView ()

@property (nonatomic, strong) IBOutlet UIButton *authorButton;

@property (nonatomic, strong) IBOutlet UIImageView  *avatarImageView;

@property (nonatomic, strong) IBOutlet UILabel  *competenceLabel;

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;

@property (nonatomic, strong) IBOutlet UILabel  *dateLabel;

@property (nonatomic, strong) IBOutlet UILabel  *descriptionLabel;

@end

@implementation FGGistInfoView

- (instancetype)init
{
    if ((self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil].firstObject)) {
        self.backgroundColor = [UIColor grayColor];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.avatarImageView setImageWithURL:self.gist.ownerAvatar placeholderImage:nil];
    
    NSString *owner = (self.gist.ownerName.length > 0)?self.gist.ownerName:NSLocalizedString(@"Unknown",);
    [self.authorButton setTitle:owner forState:UIControlStateNormal];
    
    OCTGistFile *gistFile = self.gist.files.allValues.firstObject;
    self.nameLabel.text = gistFile.filename;
    
    if ([[[FGAccountManager defaultManager] client].user.rawLogin isEqualToString:self.gist.ownerName]) {
        self.competenceLabel.text = self.gist.isPublic?NSLocalizedString(@"Public",):NSLocalizedString(@"Secret",);
    } else {
        self.competenceLabel.hidden = YES;
    }
    
    self.dateLabel.text = [self dateString];
    
    self.descriptionLabel.text = [self descriptionString];
}

- (void)setGist:(OCTGist *)gist
{
    _gist = gist;
    [self setNeedsLayout];
}

- (void)updateFrame
{
    CGSize size = [[self descriptionString] sizeWithFont:self.descriptionLabel.font constrainedToSize:CGSizeMake(self.descriptionLabel.frame.size.width, 1000)];
    self.frame = CGRectMake(0, 0, self.frame.size.width, CGRectGetMinY(self.descriptionLabel.frame)+size.height+10);
}

- (NSString *)dateString
{
    NSString *date = nil;
    if ([self.gist.creationDate timeIntervalSince1970] == [self.gist.updateDate timeIntervalSince1970]) {
        date = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"created",),[self.gist.creationDate stringFormat]];
    } else {
        date = [NSString stringWithFormat:@"%@%@\n%@%@",NSLocalizedString(@"created",),[self.gist.creationDate stringFormat],NSLocalizedString(@"updated",),[self.gist.updateDate stringFormat]];
    }
    
    return date;
}

- (NSString *)descriptionString
{
    NSString *description = (self.gist.gistDescription.length > 0)?self.gist.gistDescription:NSLocalizedString(@"No Description", );
    return description;
}

- (IBAction)onButtonAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(didSelectGist:)]) {
        [self.delegate didSelectGist:self.gist];
    }
}

@end
