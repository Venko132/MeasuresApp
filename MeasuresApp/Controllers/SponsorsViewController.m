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

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.constrHFooter.constant = [[HelperClass sharedHelper] selectSizePhone:32.0f andSizePad:64.0f];
    [self.view layoutIfNeeded];
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
    
    UIImage* img = [[DataModel Instance]sponsorLogoAtIndex:rowIndex];
    if (img)
        articleController.articleAvatar = img;
    articleController.articleTitle = [[DataModel Instance] sponsorNameAtIndex:rowIndex];
    articleController.articleSubtitle = nil;
    articleController.articleInfo = [[DataModel Instance] sponsorDetailsAtIndex:rowIndex];
    articleController.articleDate = nil;
    articleController.articleUrlImage = [[DataModel Instance] sponsorLogoURLAtIndex:rowIndex];
    articleController.articleLink = nil;
    
    [self.navigationController pushViewController:articleController animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[HelperClass sharedHelper] selectSizePhone:97.0f andSizePad:150.0f];
}

static float const hFooter = 30.0f;

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView * imgBanner = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.view.bounds), hFooter)];
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
