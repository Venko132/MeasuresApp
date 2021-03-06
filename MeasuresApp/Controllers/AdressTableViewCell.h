//
//  AdressTableViewCell.h
//  MeasuresApp
//
//  Created by Admin on 22.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelperClass.h"

@protocol ProtocolPlace <NSObject>

@required

@property (nonatomic) NSInteger rowIndex;

- (void)openMaps;
- (void)showRoute;

@end

@interface AdressTableViewCell : UITableViewCell <ProtocolUploadDataToCell>

@property (weak, nonatomic) IBOutlet UILabel * lblAdress;
@property (weak, nonatomic) IBOutlet UILabel * lblDate;
@property (weak, nonatomic) IBOutlet UIButton * btnOpenMap;
@property (weak, nonatomic) IBOutlet UIButton * btnOpenRoute;
@property (weak, nonatomic) IBOutlet UIImageView * imgPlace;

@property (nonatomic) NSInteger rowCell;
@property (weak, nonatomic) id<ProtocolPlace> delegatePlace;

- (IBAction)pressButton:(id)sender;

@end
