//
//  NewsViewController.m
//  MeasuresApp
//
//  Created by Admin on 19.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsTableViewCell.h"
#import "DetailArticleViewController.h"
#import "HelperClass.h"

@interface NewsViewController (){
    NSMutableArray * listOfNews;
    DataModel * dataModel;
}

@property (weak, nonatomic) IBOutlet UITableView *tblListOfNews;
@property (strong, nonatomic) UINavigationController * navControllerForNews;

@end

@implementation NewsViewController
@synthesize navControllerForNews;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initProperties];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tblListOfNews reloadData];
}

- (void)initProperties
{
    self.navigationItem.titleView = [HelperClass setNavBarTitle:constViewTitleNews
                                                        andWith:CGRectGetWidth(self.view.bounds)
                                                       fontSize:12.0f];
    
    listOfNews = [[NSMutableArray alloc] initWithArray:@[@"news.png"]];
    self.tblListOfNews.dataSource = self;
    self.tblListOfNews.delegate = self;
    
    [self.navigationController.navigationBar setTranslucent:NO];
}

#pragma mark - TableView delegate

static float const constHeigthOfTblCell = 125.0f;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[DataModel Instance] newsCount];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"NewsCell";
    NSInteger row = indexPath.row;
    
    NewsTableViewCell *cell = (NewsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib;
        if((row % 2) == 0)
            nib = [[NSBundle mainBundle] loadNibNamed:@"NewsTableViewCell" owner:self options:nil];
        else
             nib = [[NSBundle mainBundle] loadNibNamed:@"NewsTableViewCellR" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    [cell uploadDataToCell:row];
    
    self.tblListOfNews.estimatedRowHeight = constHeigthOfTblCell;
    //self.tblListOfNews.rowHeight = UITableViewAutomaticDimension;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NewsTableViewCell *cell = (NewsTableViewCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    float heigthCell;
    float heigthLblTitle = CGRectGetHeight(cell.lblTitle.frame);
    if(cell.heigthLblTitleStart >= heigthLblTitle)
        heigthCell = constHeigthOfTblCell;
    else {
        heigthCell = constHeigthOfTblCell + (heigthLblTitle - cell.heigthLblTitleStart);
    }
    
    return heigthCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];
    
    NSInteger row = indexPath.row;
    dataModel = [DataModel Instance];
    
    DetailArticleViewController *articleController = [[DetailArticleViewController alloc] initWithNibName:NSStringFromClass([DetailArticleViewController class]) bundle:nil];
    articleController.titleOfNavBar = constViewTitleNews;
    articleController.articleAvatar = [dataModel newsImageAtIndex:row];
    articleController.articleTitle = [dataModel newsTitleAtIndex:row];
    articleController.articleSubtitle = [dataModel newsSubtitleAtIndex:row];
    articleController.articleInfo = [dataModel newsDetailsAtIndex:row];
    articleController.articleDate = [dataModel newsDateAtIndex:row];
    
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

#pragma mark - Open detail information about selected news

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
