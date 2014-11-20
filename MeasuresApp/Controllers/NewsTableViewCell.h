//
//  NewsTableViewCell.h
//  MeasuresApp
//
//  Created by Admin on 20.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel* lblDate;
@property (weak, nonatomic) IBOutlet UILabel* lblInformation;
@property (weak, nonatomic) IBOutlet UIImageView * imgAvatar;

@end
