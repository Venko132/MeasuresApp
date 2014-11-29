//
//  SponsorsViewController.m
//  MeasuresApp
//
//  Created by Admin on 19.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import "SponsorsViewController.h"
#import "HelperClass.h"
#import "SponsorTableViewCell.h"
#import "DetailArticleViewController.h"

@interface SponsorsViewController (){
    NSMutableArray * listOfSponsors;
    DataModel * dataModel;
}

@property (weak, nonatomic) IBOutlet UITableView *tblListOfSponsors;

@end

@implementation SponsorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.titleView = [HelperClass setNavBarTitle:constViewTitleSponsors
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
    self.tblListOfSponsors.dataSource = self;
    self.tblListOfSponsors.delegate = self;
    
    [self.navigationController.navigationBar setTranslucent:NO];
    [HelperClass initLblFooter:self.lblFooter];
}

#pragma mark - TableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[DataModel Instance] sponsorsCount];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SponsorCell";
    NSInteger row = indexPath.row;
    
    SponsorTableViewCell *cell = (SponsorTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SponsorTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell uploadDataToCell:row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];
    
    NSInteger rowIndex = indexPath.row;
    DetailArticleViewController *articleController = [[DetailArticleViewController alloc] initWithNibName:NSStringFromClass([DetailArticleViewController class]) bundle:nil];
    
    articleController.titleOfNavBar = constViewTitleSponsors;
    articleController.articleAvatar = [dataModel sponsorLogoAtIndex:rowIndex];
    articleController.articleTitle = [dataModel sponsorNameAtIndex:rowIndex];
    articleController.articleSubtitle = nil;
    articleController.articleInfo = [dataModel sponsorDetailsAtIndex:rowIndex];
    articleController.articleDate = nil;
    
    [self.navigationController pushViewController:articleController animated:NO];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView * imgBanner = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.view.bounds), 30.0f)];
    imgBanner.image = [UIImage imageNamed:constImageBanner];
    return imgBanner;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
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
