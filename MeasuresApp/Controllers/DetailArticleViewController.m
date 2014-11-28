//
//  DetailNewsViewController.m
//  MeasuresApp
//
//  Created by Admin on 20.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import "DetailArticleViewController.h"
#import "HelperClass.h"
#import "ArticleTableViewCell.h"

@interface DetailArticleViewController ()

@end

@implementation DetailArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initProperties];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated
{
   // [self viewDidAppear:animated];
    [self.tblArticle reloadData];
}

- (void)initProperties
{
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:constImageMainMenu]
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(returnToPreview)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    [HelperClass setImageOnNavigationBarForController:self];
    
    if(!self.titleOfNavBar)
        self.titleOfNavBar = @" ";
    
    self.navigationItem.titleView = [HelperClass setNavBarTitle:self.titleOfNavBar
                                                        andWith:CGRectGetWidth(self.view.bounds)
                                                       fontSize:12.0f];
    
    self.tblArticle.delegate = self;
    self.tblArticle.dataSource = self;
}

- (void)returnToPreview
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"ArticleCell";
    
    ArticleTableViewCell *cell = (ArticleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ArticleTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell setFieldsDate:self.articleDate
                  title:self.articleTitle
               subtitle:self.articleSubtitle
              imgAvatar:self.articleAvatar
                   info:self.articleInfo
              imgBanner:self.articleBanner];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // ArticleTableViewCell *cell = (ArticleTableViewCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return 200.0f;//cell.cellHeight;
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
