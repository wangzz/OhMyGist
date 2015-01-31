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

@interface FGGistTableViewCell ()

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;

@property (nonatomic, strong) IBOutlet UILabel *ownerLabel;
@property (nonatomic, strong) IBOutlet UIImageView *ownerImageView;

@end

@implementation FGGistTableViewCell

/*
 <OCTGist: 0x7fe24372c920> {
 HTMLURL = "https://gist.github.com/376539ec96d5c364fdce";
 creationDate = "2015-01-30 07:19:07 +0000";
 files =     {
 "gistfile1.d" = "<OCTGistFile: 0x7fe24375bf90> {\n    filename = \"gistfile1.d\";\n    objectID = \"<null>\";\n    rawURL = \"https://gist.githubusercontent.com/anonymous/376539ec96d5c364fdce/raw/f435b9e7f04d7a726590f9b1eedc70cbff68e8e9/gistfile1.d\";\n    server = \"<OCTServer: 0x7fe243515130> {\\n    baseURL = \\\"<null>\\\";\\n}\";\n    size = 1549;\n}";
 };
 objectID = 376539ec96d5c364fdce;
 server = "<OCTServer: 0x7fe243515130> {\n    baseURL = \"<null>\";\n}";
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
    self.dateLabel.text = [self stringWithDate:self.gist.creationDate];
    self.ownerLabel.text = self.gist.ownerName;
    self.descriptionLabel.text = self.gist.gistDescription;
    [self.ownerImageView setImageWithURL:self.gist.ownerAvatar placeholderImage:nil];
}

- (NSString*)stringWithDate:(NSDate *)date
{
#define ONE_MINUTE  (60)
#define ONE_HOUR  (60*ONE_MINUTE)
    //#define ONE_DAY    (24*ONE_HOUR)
#define ONE_DAY     ((((int)[curDate timeIntervalSince1970])%(24*ONE_HOUR))+((24*ONE_HOUR)))   //当天的小时+昨天一天时间
#define ONE_MONTH    (30*ONE_DAY)
    
    NSDate * curDate = [NSDate date];
    NSTimeInterval interval = [curDate timeIntervalSinceDate:date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSString* szRet= nil;
    
    [dateFormatter setDateFormat:@"yyyy"];
    NSString* szyySelf = [dateFormatter stringFromDate:date];
    NSString* szyyCurYear = [dateFormatter stringFromDate:curDate];
    
    if (interval<= ONE_MINUTE) {
        return @"刚刚";
    }
    
    if (interval<= ONE_HOUR) {
        szRet = [NSString stringWithFormat:@"%d分钟前",(int)(interval/ONE_MINUTE)];
        return szRet;
    }
    if (interval<= ONE_DAY) {
        // 当天1小时前的显示今天具体时间（示例：今天 17：56）
        
        [dateFormatter setDateFormat:@"H:mm"];
        NSString* szHHMM = [dateFormatter stringFromDate:date];
        
        [dateFormatter setDateFormat:@"d"];
        NSString* szddSelf = [dateFormatter stringFromDate:date];
        NSString* szddCurDate = [dateFormatter stringFromDate:curDate];
        
        if ( [szddSelf isEqualToString:szddCurDate]) {
            szRet = [NSString stringWithFormat:@"今天%@",szHHMM];
        }
        else
        {
            szRet = [NSString stringWithFormat:@"昨天%@",szHHMM];
        }
        return szRet;
    }
    
    if([szyySelf isEqualToString:szyyCurYear]){
        //今年的
        [dateFormatter setDateFormat:@"M"];
        NSString* szMM = [dateFormatter stringFromDate:date];
        [dateFormatter setDateFormat:@"d"];
        NSString* szdd = [dateFormatter stringFromDate:date];
        szRet = [NSString stringWithFormat:@"%@月%@日",szMM,szdd];
        return szRet;
    }
    [dateFormatter setDateFormat:@"y"];
    NSString* szyy = [dateFormatter stringFromDate:date];
    [dateFormatter setDateFormat:@"M"];
    NSString* szMM = [dateFormatter stringFromDate:date];
    [dateFormatter setDateFormat:@"d"];
    NSString* szdd = [dateFormatter stringFromDate:date];
    szRet = [NSString stringWithFormat:@"%@年%@月%@日",szyy,szMM,szdd];
    return szRet;
}


@end
