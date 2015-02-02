//
//  FGGistTableViewCell.m
//  OhMyGist
//
//  Created by wangzz on 15-1-30.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGGistTableViewCell.h"
#import "OCTGist.h"
#import "OCTGistFile.h"
#import "UIImageView+AFNetworking.h"
#import "NSDate+FormatString.h"

@interface FGGistTableViewCell ()

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;

@property (nonatomic, strong) IBOutlet UILabel *ownerLabel;
@property (nonatomic, strong) IBOutlet UIImageView *ownerImageView;

@end

@implementation FGGistTableViewCell

/*
 <OCTGist: 0x7fb919694000> {
 HTMLURL = "https://gist.github.com/d4c423dd1003c5550fa0";
 creationDate = "2015-02-01 12:50:42 +0000";
 files =     {
 "gistfile1.txt" = "<OCTGistFile: 0x7fb919698fb0> {\n    filename = \"gistfile1.txt\";\n    language = Text;\n    objectID = \"<null>\";\n    rawURL = \"https://gist.githubusercontent.com/richardcherron/d4c423dd1003c5550fa0/raw/77ed7f51256dcf455250ccad5ec55941fe79d17d/gistfile1.txt\";\n    server = \"<OCTServer: 0x7fb9196734b0> {\\n    baseURL = \\\"<null>\\\";\\n}\";\n    size = 204;\n}";
 };
 gistDescription = "Stata: new main file";
 isPublic = 1;
 objectID = d4c423dd1003c5550fa0;
 ownerAvatar = "https://avatars.githubusercontent.com/u/2307622?v=3";
 ownerName = richardcherron;
 server = "<OCTServer: 0x7fb9196734b0> {\n    baseURL = \"<null>\";\n}";
 updateDate = "2015-02-01 12:50:42 +0000";
 }
 */

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setGist:(OCTGist *)gist
{
    _gist = gist;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    OCTGistFile *gistFile = self.gist.files.allValues.firstObject;
    self.nameLabel.text = gistFile.filename;
    self.dateLabel.text = [self.gist.creationDate stringFormat];
    
    NSString *owner = (self.gist.ownerName.length > 0)?self.gist.ownerName:NSLocalizedString(@"Unknown",);
    self.ownerLabel.text = owner;
    
    NSString *description = (self.gist.gistDescription.length > 0)?self.gist.gistDescription:NSLocalizedString(@"No Description", );
    self.descriptionLabel.text = description;
    [self.ownerImageView setImageWithURL:self.gist.ownerAvatar placeholderImage:nil];
}



@end
