//
//  PlacesViewController.m
//  MeasuresApp
//
//  Created by Admin on 19.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import "PlacesViewController.h"
#import "HelperClass.h"


@interface PlacesViewController (){
    NSMutableArray * listOfAdresses;
}
@property (weak, nonatomic) IBOutlet UITableView *tblListOfAdresses;
@property (weak, nonatomic) IBOutlet UILabel *lblFooter;

@end

@implementation PlacesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.titleView = [HelperClass setNavBarTitle:constViewTitlePlaces
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
    self.tblListOfAdresses.dataSource = self;
    self.tblListOfAdresses.delegate = self;
}

#pragma mark - TableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;//listOfAdresses.count
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"AdressCell";
    
    AdressTableViewCell *cell = (AdressTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AdressTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.selected = NO;
    cell.delegatePlace = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - ProtocolPlace delegate

- (void)showRoute{
    NSLog(@"Show route");
}

- (void)openMaps{
    NSLog(@"Open Maps");
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
