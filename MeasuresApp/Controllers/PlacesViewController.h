//
//  PlacesViewController.h
//  MeasuresApp
//
//  Created by Admin on 19.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParentForFrontViewController.h"
#import "AdressTableViewCell.h"

@interface PlacesViewController : ParentForFrontViewController<UITableViewDataSource, UITableViewDelegate, ProtocolPlace, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tblListOfAdresses;
@property (weak, nonatomic) IBOutlet UILabel *lblFooter;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrHFooter;

@end
