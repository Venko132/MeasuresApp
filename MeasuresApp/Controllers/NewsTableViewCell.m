//
//  NewsTableViewCell.m
//  MeasuresApp
//
//  Created by Admin on 20.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "ConstantsClass.h"

static float const fontSizeDate = 12.0f;
static float const fontSizeInfo = 15.0f;
static float const fontSizeInfoTitle = 17.0f;

@implementation NewsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.lblDate setFont:[UIFont fontWithName:constFontArial size:fontSizeDate]];
    self.lblDate.textColor = [UIColor grayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTitle:(NSString*)_title andInfo:(NSString*)_info
{
    NSString * allInfo = [NSString stringWithFormat:@"%@\n%@",_title,_info];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:allInfo];
    //Range
    NSRange rangeTitle = [allInfo rangeOfString:_title];
    NSRange rangeInfo = [allInfo rangeOfString:_info];
    //Color
    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:rangeTitle];
    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:rangeInfo];
    //Font
    UIFont * fontTitle = [UIFont fontWithName:constFontArial size:fontSizeInfoTitle];
    UIFont * fontInfo = [UIFont fontWithName:constFontArial size:fontSizeInfo];
    [attString addAttribute:NSFontAttributeName value:fontTitle range:rangeTitle];
    [attString addAttribute:NSFontAttributeName value:fontInfo range:rangeInfo];
    
    self.lblInformation.attributedText = attString;
}

@end
