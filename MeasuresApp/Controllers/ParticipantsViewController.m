//
//  ParticipantsViewController.m
//  MeasuresApp
//
//  Created by Admin on 19.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import "ParticipantsViewController.h"
#import "CategoryTableViewCell.h"
#import "MemberCollectionViewCell.h"

@interface ParticipantsViewController (){
    NSInteger _presentedRow;
    
    UIColor * selectedCellBGColor;
    UIColor * notSelectedCellBGColor;
    
    BOOL isCategoriesOpen;
}

@property (weak, nonatomic) IBOutlet UICollectionView *cltListOfPartisipants;
@property (weak, nonatomic) IBOutlet UILabel *lblFooter;
@property (weak, nonatomic) IBOutlet UITableView *tblListOfCategories;
@property (weak, nonatomic) IBOutlet UIView *vwContainerOfAnimation;

@end

static NSString * const cltMemberCellId = @"MemberCell";

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
    //[self.cltListOfPartisipants registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cltMemberCellId];
    UINib *cellNib = [UINib nibWithNibName:@"MemberCollectionViewCell" bundle:nil];
    [self.cltListOfPartisipants registerNib:cellNib forCellWithReuseIdentifier:cltMemberCellId];
    
    _presentedRow = -1;
    
    notSelectedCellBGColor = [HelperClass appBlueColor];
    selectedCellBGColor = [HelperClass appPinkColor];
    
    self.tblListOfCategories.dataSource = self;
    self.tblListOfCategories.delegate = self;
    
    [HelperClass initLblFooter:self.lblFooter];
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
    
    MemberCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cltMemberCellId forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - TableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    CategoryTableViewCell *cell = (CategoryTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSInteger row = indexPath.row;
    
    if (nil == cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CategoryTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *text = [NSString stringWithFormat:@"Category %i",row];
    
    cell.lblCategory.text = text;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:selectedCellBGColor];
    NSInteger row = indexPath.row;
    
    if ( row == _presentedRow )
    {
        return;
    }
    
    NSIndexPath * indexPathDeselect = [NSIndexPath indexPathForRow:_presentedRow inSection:0];
    [[tableView cellForRowAtIndexPath:indexPathDeselect] setBackgroundColor:notSelectedCellBGColor];
    
    //Filter memberships
    
    _presentedRow = row;
}

- (IBAction)animationOfListCategories:(id)sender {
    static float heigthOfTable = 100.0f;
    float heigthAnimation;
    if(!isCategoriesOpen)
    {
        heigthAnimation = heigthOfTable;
        self.vwContainerOfAnimation.hidden = NO;
        [UIView animateWithDuration:0.1f animations:^{
            //Container
            CGRect newRect = self.vwContainerOfAnimation.frame;
            newRect.size.height += heigthAnimation;
            self.vwContainerOfAnimation.frame = newRect;
            
            //CollectionView
            newRect = self.cltListOfPartisipants.frame;
            newRect.size.height -= heigthAnimation;
            newRect.origin.y += heigthAnimation;
            self.cltListOfPartisipants.frame = newRect;
            
            //Table
            /*newRect = self.tblListOfCategories.frame;
            newRect.size.height += heigthAnimation;
            self.tblListOfCategories.frame = newRect;
            */
        } completion:^(BOOL finished) {
            isCategoriesOpen = YES;
        }];
    } else {
        heigthAnimation = -heigthOfTable;
        self.vwContainerOfAnimation.hidden = NO;
        [UIView animateWithDuration:0.1f animations:^{
            //Container
            CGRect newRect = self.vwContainerOfAnimation.frame;
            newRect.size.height += heigthAnimation;
            self.vwContainerOfAnimation.frame = newRect;
            
            //CollectionView
            newRect = self.cltListOfPartisipants.frame;
            newRect.size.height -= heigthAnimation;
            newRect.origin.y += heigthAnimation;
            self.cltListOfPartisipants.frame = newRect;
            
            //Table
            /*newRect = self.tblListOfCategories.frame;
            newRect.size.height += heigthAnimation;
            self.tblListOfCategories.frame = newRect;
            */
        } completion:^(BOOL finished) {
            isCategoriesOpen = NO;
        }];
    }
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
