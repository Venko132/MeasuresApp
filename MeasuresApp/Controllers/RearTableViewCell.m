//
//  RearTableViewCell.m
//  MeasuresApp
//
//  Created by Admin on 19.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import "RearTableViewCell.h"

@implementation RearTableViewCell

static float fontSizeTitle = 14.0f;

- (void)awakeFromNib {
    // Initialization code
    [self.lblTitle setFont:[UIFont fontWithName:constFontFregatRegular size:fontSizeTitle]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
