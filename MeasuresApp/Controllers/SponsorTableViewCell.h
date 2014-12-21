//
//  SponsorTableViewCell.h
//  MeasuresApp
//
//  Created by Admin on 20.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelperClass.h"

@interface SponsorTableViewCell : UITableViewCell <ProtocolUploadDataToCell>

@property (weak, nonatomic) IBOutlet UIImageView * imgSponsorAvatar;

@end
