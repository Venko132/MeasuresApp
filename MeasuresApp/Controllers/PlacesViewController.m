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
#import "DetailArticleViewController.h"

@interface PlacesViewController (){
    NSMutableArray * listOfAdresses;
    DataModel * dataModel;
    NSInteger _presentedRow;
}

@end

@implementation PlacesViewController
@synthesize rowIndex;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.titleView = [HelperClass setNavBarTitle:constViewTitlePlaces
                                                        andWith:[HelperClass sharedHelper].widthOfView
                                                       fontSize:12.0f];
    [self initProperties];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.constrHFooter.constant = [[HelperClass sharedHelper] selectSizePhone:32.0f andSizePad:64.0f];
    [self.view layoutIfNeeded];
}

- (void)initProperties
{
    dataModel = [DataModel Instance];
    
    self.tblListOfAdresses.dataSource = self;
    self.tblListOfAdresses.delegate = self;
    
    [HelperClass initLblFooter:self.lblFooter];
    
    [self.navigationController.navigationBar setTranslucent:NO];
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
    
    UIImage* img =[[DataModel Instance] placeImageAtIndex:row];
    if (img!=nil)
        cell.imgPlace.image = img;
    
    [cell uploadDataToCell:row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[HelperClass sharedHelper] selectSizePhone:225.0f andSizePad:300];
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

#pragma mark - ProtocolPlace delegate

- (void)showRoute{
    NSLog(@"Show route");
    dataModel = [DataModel Instance];
    
    DetailArticleViewController *articleController = [[DetailArticleViewController alloc] initWithNibName:NSStringFromClass([DetailArticleViewController class]) bundle:nil];
    articleController.titleOfNavBar = [dataModel placeNameAtIndex:rowIndex];
    articleController.articleAvatar = [dataModel placeImageAtIndex:rowIndex];
    articleController.articleTitle = [dataModel placeNameAtIndex:rowIndex];
    articleController.articleSubtitle = [dataModel placeSubtitleAtIndex:rowIndex];
    articleController.articleInfo = [dataModel placeDetailsURLAtIndex:rowIndex];
    articleController.articleDate = [dataModel placeDateAtIndex:rowIndex];
    articleController.articleLink = [dataModel placeLinkAtIndex:rowIndex];
    articleController.articleUrlImage = [dataModel placesImageURLAtIndex:rowIndex];
    
    [self.navigationController pushViewController:articleController animated:NO];
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
    NSURL * baseUrlMapsApp;
    NSString * titleAlert;
    NSString * _titleApp;
    //coordinates for the place we want to display
    CLLocationCoordinate2D locationCoordinate = [dataModel placeMapPointAtIndex:self.rowIndex].coordinate;
    NSString * strLocationName = [dataModel placeNameAtIndex:self.rowIndex];
    
    switch (buttonIndex) {
        case 0:
            pathOfChoosedApp = [NSString stringWithFormat:@"comgooglemaps://?center=%f,%f&zoom=12",locationCoordinate.latitude,locationCoordinate.longitude];
            NSLog(@"%@",pathOfChoosedApp);
            _titleApp = mapsGoogle;
            baseUrlMapsApp = [NSURL URLWithString:@"comgooglemaps://"];
            break;
        case 2:
            pathOfChoosedApp = [NSString stringWithFormat:@"yandexmaps://maps.yandex.ru/?pt=%f,%f&ll=%f,%f", locationCoordinate.longitude, locationCoordinate.latitude, locationCoordinate.longitude, locationCoordinate.latitude];
            _titleApp = mapsYandex;
            baseUrlMapsApp = [NSURL URLWithString:@"yandexmaps://maps.yandex.ru/"];
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
        item.name = strLocationName;
        [item openInMapsWithLaunchOptions:nil];
    } else if (urlApp) {
        //Google Maps
        //construct a URL using the comgooglemaps schema
        
        if (![[UIApplication sharedApplication] canOpenURL:baseUrlMapsApp]) {
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
