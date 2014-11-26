//
//  NewsTableViewCell.m
//  MeasuresApp
//
//  Created by Admin on 20.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import "NewsTableViewCell.h"

static float const fontSizeDate = 10.0f;
static float const fontSizeInfo = 10.0f;
static float const fontSizeInfoTitle = 16.0f;

@implementation NewsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.lblDate setFont:[UIFont fontWithName:constFontArial size:fontSizeDate]];
    self.lblDate.textColor = [HelperClass appGrayColor];
    
    self.lblTitle.textColor = [HelperClass appPink2Color];
    [self.lblTitle setFont:[UIFont fontWithName:constFontFregatBold size:fontSizeInfoTitle]];
    
    [self.lblSubTitle setFont:[UIFont fontWithName:constFontArial size:fontSizeInfo]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSMutableAttributedString*)setTitle:(NSString*)_title andInfo:(NSString*)_info
{
    NSString * allInfo = [NSString stringWithFormat:@"%@\n%@",_title,_info];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:allInfo];
    //Range
    NSRange rangeTitle = [allInfo rangeOfString:_title];
    NSRange rangeInfo = [allInfo rangeOfString:_info options:NSBackwardsSearch];
    
    //Font
    UIFont * fontTitle = [UIFont fontWithName:constFontFregatBold size:fontSizeInfoTitle];
    UIFont * fontInfo = [UIFont fontWithName:constFontArial size:fontSizeInfo];
    //Color
    if(rangeTitle.location != NSNotFound){
        [attString addAttribute:NSForegroundColorAttributeName value:[HelperClass appPink2Color] range:rangeTitle];
        [attString addAttribute:NSFontAttributeName value:fontTitle range:rangeTitle];
    }
    if(rangeInfo.location != NSNotFound){
        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:rangeInfo];
        [attString addAttribute:NSFontAttributeName value:fontInfo range:rangeInfo];
    }
    
    return attString;
    
}

- (void)uploadDataToCell:(NSInteger)rowIndex
{
    DataModel * dataModel = [DataModel Instance];
    self.lblDate.text = [HelperClass convertDate:[dataModel newsDateAtIndex:rowIndex] toStringFormat:@"dd MMMM yyyy"];
    NSString * test = @"addd addd addd addd addd addd addd addd addd addd addd addd addd addd addd addd addd addd ";
    NSString * test2 = @"addd addd addd addd addd addd addd addd addd addd addd addd addd addd addd addd addd addd ";
    self.lblTitle.attributedText = [self setTitle:test/*[dataModel newsTitleAtIndex:rowIndex]*/
                                          andInfo:test2/*[dataModel newsSubtitleAtIndex:rowIndex]*/];
    self.heigthLblTitleStart = CGRectGetHeight(self.lblTitle.frame);
    [self.lblTitle sizeToFit];
    //self.lblSubTitle.text = @"addd addd addd addd addd addd addd addd addd addd addd addd addd addd addd addd addd addd ";//[dataModel newsSubtitleAtIndex:rowIndex];
}

@end
