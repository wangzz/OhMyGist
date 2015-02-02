//
//  FGTitleTableViewCell.m
//  OhMyGist
//
//  Created by wangzz on 15-2-2.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGTitleTableViewCell.h"

@interface FGTitleTableViewCell ()

@property (nonatomic, strong) IBOutlet UILabel  *nameLabel;

@property (nonatomic, strong) IBOutlet UIImageView  *accessImageView;

@end

@implementation FGTitleTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self setNeedsLayout];
}

- (void)setShowAccess:(BOOL)showAccess
{
    _showAccess = showAccess;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.nameLabel.text = self.title;
    self.accessImageView.hidden = !self.showAccess;
}

@end
