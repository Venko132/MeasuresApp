//
//  ParticipantsViewController.h
//  MeasuresApp
//
//  Created by Admin on 19.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParentForFrontViewController.h"

@interface ParticipantsViewController : ParentForFrontViewController <UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *cltListOfPartisipants;
@property (weak, nonatomic) IBOutlet UILabel *lblFooter;
@property (weak, nonatomic) IBOutlet UITableView *tblListOfCategories;
@property (weak, nonatomic) IBOutlet UIView *vwContainerOfAnimation;
@property (weak, nonatomic) IBOutlet UIButton *btnCategory;
@property (weak, nonatomic) IBOutlet UIView *vwContainerFooter;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrHFooter;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrHContainerTbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constHContainerBtnCategory;


@end
