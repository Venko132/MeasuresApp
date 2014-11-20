//
//  RearViewController.m
//  MeasuresApp
//
//  Created by Admin on 19.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import "RearViewController.h"
#import "SWRevealViewController.h"
#import "PosterViewController.h"
#import "ParticipantsViewController.h"
#import "SponsorsViewController.h"
#import "PlacesViewController.h"
#import "NewsViewController.h"
#import "InstagramViewController.h"

@interface RearViewController ()
{
    NSInteger _presentedRow;
    NSArray * listOfEvents;
}

@property (weak, nonatomic) IBOutlet UITableView *tblListOfEvents;

@end

@implementation RearViewController

@synthesize tblListOfEvents;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initProperties];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initProperties
{
    listOfEvents = @[@"Афиша",@"Участники",@"Спонсоры",@"Места",@"Новости",@"Instagram"];
    
    tblListOfEvents.dataSource = self;
    tblListOfEvents.delegate  = self;
}

#pragma mark - TableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listOfEvents.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSInteger row = indexPath.row;
    
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    NSString *text = [listOfEvents objectAtIndex:row];
    
    cell.textLabel.text = text;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWRevealViewController *revealController = self.revealViewController;
    
    // selecting row
    NSInteger row = indexPath.row;
    
    // if we are trying to push the same row or perform an operation that does not imply frontViewController replacement
    // we'll just set position and return
    
    if ( row == _presentedRow )
    {
        [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
        return;
    }
    
    // otherwise we'll create a new frontViewController and push it with animation
    UIViewController *newFrontController = nil;
    
    switch (row) {
        case 0:
            newFrontController = [[PosterViewController alloc] init];
            break;
        case 1:
            newFrontController = [[ParticipantsViewController alloc] init];
            break;
        case 2:
            newFrontController = [[SponsorsViewController alloc] init];
            break;
        case 3:
            newFrontController = [[PlacesViewController alloc] init];
            break;
        case 4:
            newFrontController = [[NewsViewController alloc] init];
            break;
        case 5:
            newFrontController = [[InstagramViewController alloc] init];
            break;
            
        default:
            break;
    }
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newFrontController];
    [revealController pushFrontViewController:navigationController animated:NO];
    [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    _presentedRow = row;  // <- store the presented row
    
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
