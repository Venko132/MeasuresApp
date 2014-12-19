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
#import "RearTableViewCell.h"

@interface RearViewController ()
{
    NSInteger _presentedRow;
    NSArray * listOfEvents;
    
    UIColor * selectedCellBGColor;
    UIColor * notSelectedCellBGColor;
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
   // NSInteger indexOfAction =  [[DataModel Instance] GetNearestAction];
    NSString * nameAction = @"Главная";//[[DataModel Instance] placeNameAtIndex:indexOfAction];
    /*if(!nameAction)
        nameAction = constImagePoster;
     */
    listOfEvents = @[nameAction,@"Новости",@"Участники",@"Партнеры"/*,@"Места"*//*,@"Instagram"*/];
    
    tblListOfEvents.dataSource = self;
    tblListOfEvents.delegate  = self;
    
    _presentedRow = 0;
    
    notSelectedCellBGColor = [HelperClass appBlueColor];
    selectedCellBGColor = [HelperClass appPinkColor];
    
    [self.tblListOfEvents reloadData];
    NSIndexPath * indexFirst = [NSIndexPath indexPathForRow:0 inSection:0];
    [[self.tblListOfEvents cellForRowAtIndexPath:indexFirst] setBackgroundColor:selectedCellBGColor];
}


#pragma mark - TableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listOfEvents.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[HelperClass sharedHelper] selectSizePhone:54.0f andSizePad:108.0f];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    RearTableViewCell *cell = (RearTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSInteger row = indexPath.row;
    
    if (nil == cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RearTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *text = [listOfEvents objectAtIndex:row];
    
    cell.lblTitle.text = text;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:selectedCellBGColor];
    // Transition
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
    
    NSIndexPath * indexPathDeselect = [NSIndexPath indexPathForRow:_presentedRow inSection:0];
    [[tableView cellForRowAtIndexPath:indexPathDeselect] setBackgroundColor:notSelectedCellBGColor];
    // otherwise we'll create a new frontViewController and push it with animation
    UIViewController *newFrontController = nil;
    
    switch (row) {
        case 0:
            newFrontController = [[PosterViewController alloc] init];
            break;
        case 1:
            newFrontController = [[NewsViewController alloc] init];
            break;
        case 2:
            newFrontController = [[ParticipantsViewController alloc] init];
            break;
        case 3:
            newFrontController = [[SponsorsViewController alloc] init];
            break;
        case 4:
            newFrontController = [[PlacesViewController alloc] init];
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (cell.isSelected == YES)
    {
        [cell setBackgroundColor:selectedCellBGColor];
    }
    else
    {
        [cell setBackgroundColor:notSelectedCellBGColor];
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
