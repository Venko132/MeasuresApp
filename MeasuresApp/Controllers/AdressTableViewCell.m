//
//  AdressTableViewCell.m
//  MeasuresApp
//
//  Created by Admin on 22.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import "AdressTableViewCell.h"
#import "ConstantsClass.h"

static float const fontSizeDate = 12.0f;
static float const fontSizeAdress = 17.0f;
static float const fontSizeBtnTitle = 12.0f;

@implementation AdressTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.lblDate setFont:[UIFont fontWithName:constFontArial size:fontSizeDate]];
    self.lblDate.textColor = [UIColor grayColor];
    
    [self.lblAdress setFont:[UIFont fontWithName:constFontArial size:fontSizeAdress]];
    self.lblDate.textColor = [UIColor blueColor];
    
    [self.btnOpenMap.titleLabel setFont:[UIFont fontWithName:constFontArial size:fontSizeBtnTitle]];
    [self.btnOpenRoute.titleLabel setFont:[UIFont fontWithName:constFontArial size:fontSizeBtnTitle]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)pressButton:(id)sender{
    if([sender tag] == 101){
        if([self.delegatePlace respondsToSelector:@selector(openMaps)])
            [self.delegatePlace performSelector:@selector(openMaps)];
    } else {
        if([self.delegatePlace respondsToSelector:@selector(showRoute)])
            [self.delegatePlace performSelector:@selector(showRoute)];
    }
}

@end
