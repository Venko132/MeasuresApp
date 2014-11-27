//
//  MemberCollectionViewCell.m
//  MeasuresApp
//
//  Created by Admin on 25.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import "MemberCollectionViewCell.h"

static float fontSize = 10.0f;

@implementation MemberCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [self initProperties];
}

- (void)initProperties{
    [self.lblTitle setFont:[UIFont fontWithName:constFontNautilusPompilius size:fontSize]];
    self.lblTitle.textColor = [HelperClass appGrayColor];
    
    self.imgAvatar.layer.cornerRadius = CGRectGetWidth(self.imgAvatar.frame)/2;
}

- (void)uploadDataToCell:(NSInteger)rowIndex
{
    self.lblTitle.text = [[DataModel Instance] participantsNameAtIndex:rowIndex];
    UIImage* img = [[DataModel Instance] participantsLogoAtIndex:rowIndex];
    if (img)
        self.imgAvatar.image = img;
}

@end
