//
//  RearTableViewCell.m
//  MeasuresApp
//
//  Created by Admin on 19.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import "RearTableViewCell.h"
#import "HelperClass.h"

@implementation RearTableViewCell

static float fontSizeTitlePhone = 21.0f;
static float fontSizeTitlePad = 42.0f;

- (void)awakeFromNib {
    // Initialization code
    [self.lblTitle setFont:[UIFont fontWithName:constFontFregatRegular size:[[HelperClass sharedHelper] selectSizePhone:fontSizeTitlePhone andSizePad:fontSizeTitlePad]]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
