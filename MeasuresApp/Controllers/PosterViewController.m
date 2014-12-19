//
//  PosterViewController.m
//  MeasuresApp
//
//  Created by Admin on 19.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import "PosterViewController.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "AppDelegate.h"
#import "FacebookHelper.h"

static NSArray  * SCOPE = nil;

//Phone
static float const fontSizeMessageFirstLinePhone = 24.0f;
static float const fontSizeMessageSecondLinePhone = 10.0f;

static float const fontSizePlaceOfActionPhone = 12.0f;
static float const fontSizeDateOfActionPhone = 24.0f;

static float const fontSizeTitleOfActionPhone = 24.0f;

//Pad
static float const fontSizeMessageFirstLinePad = 48.0f;
static float const fontSizeMessageSecondLinePad = 20.0f;

static float const fontSizePlaceOfActionPad = 24.0f;
static float const fontSizeDateOfActionPad = 48.0f;

static float const fontSizeTitleOfActionPad = 48.0f;

@interface PosterViewController (){
    DataModel * dataModel;
    NSInteger indexOfAction;
}

@end

@implementation PosterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initProperties];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)initProperties
{
    dataModel = [DataModel Instance];
    indexOfAction = [dataModel GetNearestAction];
    
    NSString * nameAction = @"Главная";//[[DataModel Instance] placeNameAtIndex:indexOfAction];
    if(!nameAction)
        nameAction = @"Главная";
    
    self.navigationItem.titleView = [HelperClass setNavBarTitle:nameAction
                                                        andWith:CGRectGetWidth(self.view.bounds)
                                                       fontSize:12.0f];
    [HelperClass sharedHelper].widthOfView = CGRectGetWidth(self.view.bounds);
    [self.navigationController.navigationBar setTranslucent:NO];
    [self setCornerRadiusForView:self.btnShareFB];
    
    [self initAlertMessageAbouteFinishAction];
    [HelperClass initLblFooter:self.lblFooter];
    
    [self.lblTitleForSocialShare setFont:[UIFont fontWithName:constFontNautilusPompilius size:[[HelperClass sharedHelper] selectSizePhone:12.0f andSizePad:24.0f]]];
    
    //Show Alert of End Action
    NSString * alert = [dataModel placeDateTextAtIndex:indexOfAction];
    
    if(![alert isEqualToString:constMessageFinish])
        self.vwContainerForMessageAboutFinish.hidden = YES;
    
    [self initLblTitleOfAction];
    
    self.imgPlaceOfAction.image = [dataModel placeImageAtIndex:indexOfAction];
    
    self.lblInfo.text = [[[dataModel placeSubtitleAtIndex:indexOfAction] stringByConvertingHTMLToPlainText]  stringByDecodingHTMLEntities];

    [self initLblDateAndPlace];
}

#pragma mark - Other methods

- (void)initLblTitleOfAction{
    [self.lblTitleOfAction setFont:[UIFont fontWithName:constFontFregatBold size:[[HelperClass sharedHelper] selectSizePhone:fontSizeTitleOfActionPhone andSizePad:fontSizeTitleOfActionPad]]];
    self.lblTitleOfAction.textColor = [UIColor whiteColor];
    self.lblTitleOfAction.text = [dataModel placeNameAtIndex:indexOfAction];
    self.lblTitleOfAction.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ribbonBg.png"]];
}

- (void)initAlertMessageAbouteFinishAction
{
    NSString * firstLine = @"Это мероприятие уже закончилось";
    NSString * secondLine = @"  но мы обязательно придумаем что-нибудь еще";
    //Font
    UIFont * fontTitle = [UIFont fontWithName:constFontFregatBold size:[[HelperClass sharedHelper] selectSizePhone:fontSizeMessageFirstLinePhone andSizePad:fontSizeMessageFirstLinePad]];
    UIFont * fontInfo = [UIFont fontWithName:constFontNautilusPompilius size:[[HelperClass sharedHelper] selectSizePhone:fontSizeMessageSecondLinePhone andSizePad:fontSizeMessageSecondLinePad]];
    
    [self.lblAlertFinishFirstLine setFont:fontTitle];
    [self.lblAlertSecondLine setFont:fontInfo];
    
    self.lblAlertFinishFirstLine.text = firstLine;
    self.lblAlertSecondLine.text = secondLine;
    
    [self.lblAlertFinishFirstLine sizeToFit];
 
}

- (void)initLblDateAndPlace
{
    [self.lblPlaceOfAction setFont:[UIFont fontWithName:constFontNautilusPompilius size:[[HelperClass sharedHelper] selectSizePhone:fontSizePlaceOfActionPhone andSizePad:fontSizePlaceOfActionPad]]];
    [self.lblDateOfAction setFont:[UIFont fontWithName:constFontNautilusPompilius size:[[HelperClass sharedHelper] selectSizePhone:fontSizeDateOfActionPhone andSizePad:fontSizeDateOfActionPad]]];
    
    self.lblDateOfAction.text = [HelperClass convertDate:[dataModel placeDateAtIndex:indexOfAction] toStringFormat:@"dd MMMM yyyy"];
    self.lblPlaceOfAction.text = [[[dataModel placeDateTextAtIndex:indexOfAction] stringByConvertingHTMLToPlainText]  stringByDecodingHTMLEntities];
}

- (void)setCornerRadiusForView:(UIView*)_viewS
{
    _viewS.layer.cornerRadius = CGRectGetWidth(_viewS.bounds)/2;
}

#pragma mark - Share message in social networks

#pragma mark - VK
- (IBAction)shareToVK:(id)sender {
    if(!SCOPE)
        SCOPE = @[VK_PER_FRIENDS, VK_PER_WALL, VK_PER_AUDIO, VK_PER_PHOTOS, VK_PER_NOHTTPS, VK_PER_EMAIL, VK_PER_MESSAGES];
    [VKSdk initializeWithDelegate:self andAppId:VKApiID];
    if ([VKSdk wakeUpSession])
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self startWorkingWithVK];
        }];
    } else {
        [VKSdk authorize:SCOPE revokeAccess:YES];
    }
}

- (void)startWorkingWithVK
{
    VKShareDialogController * shareDialog = [VKShareDialogController new];
    shareDialog.text = [dataModel placeNameAtIndex:indexOfAction];
    if([dataModel placeImageAtIndex:indexOfAction])
        shareDialog.uploadImages = @[[VKUploadImage uploadImageWithImage:[dataModel placeImageAtIndex:indexOfAction]
                                                               andParams:[VKImageParameters jpegImageWithQuality:0.9]]];
    
    if([dataModel placeLinkAtIndex:indexOfAction] && ([dataModel placeLinkAtIndex:indexOfAction].length > 0))
        shareDialog.otherAttachmentsStrings = @[[dataModel placeLinkAtIndex:indexOfAction]];
    else shareDialog.otherAttachmentsStrings = @[strBaseUrl];
    
    [shareDialog presentIn:self];
}

- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
    VKCaptchaViewController *vc = [VKCaptchaViewController captchaControllerWithError:captchaError];
    [vc presentIn:self];
}

- (void)vkSdkTokenHasExpired:(VKAccessToken *)expiredToken {
    [self shareToVK:nil];
}

- (void)vkSdkReceivedNewToken:(VKAccessToken *)newToken {
    
    [self performSelector:@selector(startWorkingWithVK) withObject:nil afterDelay:1.0f];
}

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)vkSdkAcceptedUserToken:(VKAccessToken *)token {
    [self performSelector:@selector(startWorkingWithVK) withObject:nil afterDelay:1.0f];
}
- (void)vkSdkUserDeniedAccess:(VKError *)authorizationError {
    [[[UIAlertView alloc] initWithTitle:nil message:@"Access denied" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}

#pragma mark - Share message in social networks

-(IBAction)facebookPost:(id)sender{
    [[HelperClass sharedHelper] shareFacebook:[dataModel placeNameAtIndex:indexOfAction]
                              andDescrioption:[dataModel placeSubtitleAtIndex:indexOfAction]
                                        image:[dataModel placeImageAtIndex:indexOfAction]
                                forController:self
                                    andImgUrl:[dataModel placesImageURLAtIndex:indexOfAction]
                                      andLink:[dataModel placeLinkAtIndex:indexOfAction]];
}

-(IBAction)twitterPost:(id)sender{

    [[HelperClass sharedHelper] shareTwitter:[dataModel placeNameAtIndex:indexOfAction] andDescrioption:[dataModel placeSubtitleAtIndex:indexOfAction]
                                       image:[dataModel placeImageAtIndex:indexOfAction]
                               forController:self
                                   andImgUrl:[dataModel placesImageURLAtIndex:indexOfAction]
                                     andLink:[dataModel placeLinkAtIndex:indexOfAction]];
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
