//
//  NewsViewController.m
//  MeasuresApp
//
//  Created by Admin on 19.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsTableViewCell.h"
#import "DetailNewsViewController.h"

@interface NewsViewController (){
    NSMutableArray * listOfNews;
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

- (void)initProperties
{
    listOfNews = [[NSMutableArray alloc] initWithArray:@[@"news.png"]];
    self.tblListOfNews.dataSource = self;
    self.tblListOfNews.delegate = self;
}

#pragma mark - TableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;//listOfSponsors.count;
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
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];
    
    /*
    if(!navControllerForNews)
        navControllerForNews = [[UINavigationController alloc] initWithRootViewController:];
     */
    
    DetailNewsViewController *detailController = [[DetailNewsViewController alloc] initWithNibName:NSStringFromClass([DetailNewsViewController class]) bundle:nil];
    [self.navigationController pushViewController:detailController animated:YES];
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
