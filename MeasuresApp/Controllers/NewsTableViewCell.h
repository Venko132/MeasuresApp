//
//  NewsTableViewCell.h
//  MeasuresApp
//
//  Created by Admin on 20.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelperClass.h"

@interface NewsTableViewCell : UITableViewCell<ProtocolUploadDataToCell>

@property (weak, nonatomic) IBOutlet UILabel* lblDate;
@property (weak, nonatomic) IBOutlet UILabel* lblTitle;
@property (weak, nonatomic) IBOutlet UILabel* lblSubTitle;
@property (weak, nonatomic) IBOutlet UIImageView * imgAvatar;

@property (nonatomic) float heigthLblTitleStart;

//- (void)setTitle:(NSString*)_title andInfo:(NSString*)_info;

@end
