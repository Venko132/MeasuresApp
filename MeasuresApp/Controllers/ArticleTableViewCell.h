//
//  ArticleTableViewCell.h
//  MeasuresApp
//
//  Created by Admin on 28.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsTableViewCell.h"

@interface ArticleTableViewCell : NewsTableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblTopInfo;
@property (strong, nonatomic) IBOutlet UILabel *lblBottomInfo;
@property (strong, nonatomic) UIImageView *imgBanner;

@property (weak, nonatomic) IBOutlet UIView * vwLeftContainer;
@property (weak, nonatomic) IBOutlet UIView * vwRightContainer;

@property (assign, nonatomic) float cellHeight;

- (void)setFieldsDate:(NSDate*)_dateSet
                title:(NSString*)_titleSet
             subtitle:(NSString*)_subtitleSet
            imgAvatar:(UIImage*)_imgAvatarSet
                 info:(NSString*)_infoSet
            imgBanner:(UIImage*)_imgBannerSet;
- (void)setLblInfoAttribute:(UILabel*)_lblInfo;

@end
