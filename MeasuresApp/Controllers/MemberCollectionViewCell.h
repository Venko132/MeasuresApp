//
//  MemberCollectionViewCell.h
//  MeasuresApp
//
//  Created by Admin on 25.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;

- (void)initProperties;

@end
