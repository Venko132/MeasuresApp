//
//  DetailNewsViewController.h
//  MeasuresApp
//
//  Created by Admin on 20.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailArticleViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSString * titleOfNavBar;
@property (assign, nonatomic) NSInteger indexChoosenRow;

@property (weak, nonatomic) IBOutlet UITableView *tblArticle;

@property (strong, nonatomic) NSDate *      articleDate;
@property (strong, nonatomic) NSString *    articleTitle;
@property (strong, nonatomic) NSString *    articleSubtitle;
@property (strong, nonatomic) NSString *    articleInfo;
@property (strong, nonatomic) UIImage *     articleAvatar;
@property (strong, nonatomic) UIImage *     articleBanner;

@end
