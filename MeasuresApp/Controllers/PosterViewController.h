//
//  PosterViewController.h
//  MeasuresApp
//
//  Created by Admin on 19.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParentForFrontViewController.h"
#import <VKSdk.h>

@interface PosterViewController : ParentForFrontViewController<VKSdkDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblFooter;
@property (weak, nonatomic) IBOutlet UIButton *btnShareFB;
@property (weak, nonatomic) IBOutlet UIButton *btnShareTW;
@property (weak, nonatomic) IBOutlet UIButton *btnShareVK;
@property (weak, nonatomic) IBOutlet UIImageView *imgPlaceOfAction;
@property (weak, nonatomic) IBOutlet UILabel *lblDateOfAction;
@property (weak, nonatomic) IBOutlet UILabel *lblPlaceOfAction;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleOfAction;
@property (weak, nonatomic) IBOutlet UILabel *lblMessageAboutFinishAction;
@property (weak, nonatomic) IBOutlet UILabel *lblInfo;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleForSocialShare;
@property (weak, nonatomic) IBOutlet UIImageView *imgBannerTop;
@property (weak, nonatomic) IBOutlet UIView *vwContainerForMessageAboutFinish;
@property (weak, nonatomic) IBOutlet UIView *vwContainerDateAndPlace;


@end
