//
//  PlacesViewController.m
//  MeasuresApp
//
//  Created by Admin on 19.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import "PlacesViewController.h"
#import "HelperClass.h"
#import <MapKit/MapKit.h>

@interface PlacesViewController (){
    NSMutableArray * listOfAdresses;
    DataModel * dataModel;
    NSInteger _presentedRow;
}
@property (weak, nonatomic) IBOutlet UITableView *tblListOfAdresses;
@property (weak, nonatomic) IBOutlet UILabel *lblFooter;

@end

@implementation PlacesViewController
@synthesize rowIndex;

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
    dataModel = [DataModel Instance];
    
    self.tblListOfAdresses.dataSource = self;
    self.tblListOfAdresses.delegate = self;
    
    [HelperClass initLblFooter:self.lblFooter];
}

#pragma mark - TableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataModel placesCount];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    static NSString *simpleTableIdentifier = @"AdressCell";
    
    AdressTableViewCell *cell = (AdressTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AdressTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.delegatePlace = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell uploadDataToCell:row];
    
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView * imgBanner = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.view.bounds), 30.0f)];
    imgBanner.image = [UIImage imageNamed:constImageBanner];
    return imgBanner;
}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

#pragma mark - ProtocolPlace delegate

- (void)showRoute{
    NSLog(@"Show route");
}

- (void)openMaps{
    NSLog(@"Open Maps");
    [self openUIActionSheetListOfMapsApp];
}

#pragma mark - UIActionSheet delegate

static NSString * const actionTitle = @"Выберите карту";
static NSString * const mapsGoogle = @"Google Maps";
static NSString * const mapsYandex = @"Yandex Maps";

- (void)openUIActionSheetListOfMapsApp
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:actionTitle
                                                             delegate:self
                                                    cancelButtonTitle:@"Отменить"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:mapsGoogle,@"Apple Maps",mapsYandex,nil];
    
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString * pathOfChoosedApp;
    NSString * titleAlert;
    NSString * _titleApp;
    //coordinates for the place we want to display
    CLLocationCoordinate2D locationCoordinate = [dataModel placeMapURLAtIndex:self.rowIndex].coordinate;
    
    switch (buttonIndex) {
        case 0:
            pathOfChoosedApp = [NSString stringWithFormat:@"comgooglemaps://?center=%f,%f",locationCoordinate.latitude,locationCoordinate.longitude];
            _titleApp = mapsGoogle;
            break;
        case 2:
            pathOfChoosedApp = [NSString stringWithFormat:@"yandexmaps://maps.yandex.ru/?pt=%f,%f&ll=%f,%f", locationCoordinate.longitude, locationCoordinate.latitude, locationCoordinate.longitude, locationCoordinate.latitude];
            _titleApp = mapsYandex;
            break;
            
        default:
            break;
    }
    
    NSURL *urlApp = nil;
    if(pathOfChoosedApp){
        urlApp = [NSURL URLWithString:pathOfChoosedApp];
        titleAlert = [NSString stringWithFormat:@"%@ приложения не установлено",_titleApp];
    }
    
    if (buttonIndex == 1) {
        //Apple Maps, using the MKMapItem class
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:locationCoordinate addressDictionary:nil];
        MKMapItem *item = [[MKMapItem alloc] initWithPlacemark:placemark];
        item.name = nil;
        [item openInMapsWithLaunchOptions:nil];
    } else if (urlApp) {
        //Google Maps
        //construct a URL using the comgooglemaps schema
        
        if (![[UIApplication sharedApplication] canOpenURL:urlApp]) {
            NSLog(@"Maps app is not installed");
            [HelperClass showMessage:titleAlert withTitle:@"Ошибка"];
            //left as an exercise for the reader: open the Google Maps mobile website instead!
        } else {
            [[UIApplication sharedApplication] openURL:urlApp];
        }
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
