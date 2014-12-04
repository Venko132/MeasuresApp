//
//  DetailNewsViewController.h
//  MeasuresApp
//
//  Created by Admin on 20.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VKSdk.h>

@interface DetailArticleViewController : UIViewController <UIWebViewDelegate,VKSdkDelegate>

@property (strong, nonatomic) NSString * titleOfNavBar;
@property (assign, nonatomic) NSInteger indexChoosenRow;

@property (strong, nonatomic) NSDate *      articleDate;
@property (strong, nonatomic) NSString *    articleTitle;
@property (strong, nonatomic) NSString *    articleSubtitle;
@property (strong, nonatomic) NSString *    articleInfo;
@property (strong, nonatomic) UIImage *     articleAvatar;
@property (strong, nonatomic) UIImage *     articleBanner;
@property (strong, nonatomic) NSString *    articleLink;
@property (strong, nonatomic) NSString *    articleUrlImage;

@property (weak, nonatomic) IBOutlet UITextView *txtVwInfo;
@property (weak, nonatomic) IBOutlet UIWebView *wbVwInfo;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleForSocialShare;

@property (weak, nonatomic) IBOutlet UILabel *lblFooter;
@property (weak, nonatomic) IBOutlet UIButton *btnShareFB;
@property (weak, nonatomic) IBOutlet UIButton *btnShareTW;
@property (weak, nonatomic) IBOutlet UIButton *btnShareVK;

@end
