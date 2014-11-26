//
//  AdressTableViewCell.m
//  MeasuresApp
//
//  Created by Admin on 22.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import "AdressTableViewCell.h"

static float const fontSizeDate = 10.0f;
static float const fontSizeAdress = 20.0f;
static float const fontSizeBtnTitle = 10.0f;

@implementation AdressTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.lblDate setFont:[UIFont fontWithName:constFontNautilusPompilius size:fontSizeDate]];
    self.lblDate.textColor = [HelperClass appGrayColor];
    
    [self.lblAdress setFont:[UIFont fontWithName:constFontNautilusPompilius size:fontSizeAdress]];
    self.lblAdress.textColor = [HelperClass appBlueColor];
    
    [self.btnOpenMap.titleLabel setFont:[UIFont fontWithName:constFontArialBold size:fontSizeBtnTitle]];
    [self.btnOpenRoute.titleLabel setFont:[UIFont fontWithName:constFontArialBold size:fontSizeBtnTitle]];
    
    self.btnOpenMap.titleLabel.numberOfLines = 0;
    self.btnOpenRoute.titleLabel.numberOfLines = 0;
    
    [self.btnOpenMap setTitle:@"Посмотреть на\nкарте" forState:UIControlStateNormal];
    [self.btnOpenRoute setTitle:@"Посмотреть схему\nпроезда" forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)pressButton:(id)sender{
    [self.delegatePlace setRowIndex:self.rowCell];
    if([sender tag] == 101){
        if([self.delegatePlace respondsToSelector:@selector(openMaps)])
            [self.delegatePlace performSelector:@selector(openMaps)];
    } else {
        if([self.delegatePlace respondsToSelector:@selector(showRoute)])
            [self.delegatePlace performSelector:@selector(showRoute)];
    }
}

- (void)uploadDataToCell:(NSInteger)rowIndex
{
    DataModel * dataModel = [DataModel Instance];
    self.lblAdress.text = [dataModel placeNameAtIndex:rowIndex];
    self.lblDate.text = [dataModel placeSubtitleAtIndex:rowIndex];
    self.rowCell = rowIndex;
}

@end
