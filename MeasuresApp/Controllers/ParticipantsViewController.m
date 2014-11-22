//
//  ParticipantsViewController.m
//  MeasuresApp
//
//  Created by Admin on 19.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import "ParticipantsViewController.h"

@interface ParticipantsViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *cltListOfPartisipants;
@property (weak, nonatomic) IBOutlet UILabel *lblFooter;

@end

@implementation ParticipantsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.titleView = [HelperClass setNavBarTitle:constViewTitleParticipants
                                                        andWith:CGRectGetWidth(self.view.bounds)
                                                       fontSize:12.0f];
    [self initProperties];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initProperties
{
    self.cltListOfPartisipants.dataSource = self;
    self.cltListOfPartisipants.delegate = self;
    [self.cltListOfPartisipants registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
}

#pragma mark - CollectionView delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [[collectionView cellForItemAtIndexPath:indexPath] setSelected:NO];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor blueColor];
    cell.layer.cornerRadius = CGRectGetWidth(cell.layer.bounds)/2;
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
