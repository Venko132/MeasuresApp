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


static NSString *const TOKEN_KEY    = @"my_application_access_token";
static NSString *const SHARE_DIALOG = @"Test share dialog";
static NSArray  * SCOPE = nil;
static NSString *const VKApiID      = @"4642356";

static float const fontSizeMessageFirstLine = 19.0f;
static float const fontSizeMessageSecondLine = 9.0f;

static float const fontSizePlaceOfAction = 12.0f;
static float const fontSizeDateOfAction = 24.0f;

@interface PosterViewController (){
    DataModel * dataModel;
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

- (void)initProperties
{
    dataModel = [DataModel Instance];
    self.navigationItem.titleView = [HelperClass setNavBarTitle:@"Афиша"
                                                        andWith:CGRectGetWidth(self.view.bounds)
                                                       fontSize:12.0f];
    //[self setCornerRadiusForView:self.btnShareTW];
    [self setCornerRadiusForView:self.btnShareFB];
    //[self setCornerRadiusForView:self.btnShareVK];
    
    [self initLblMessageAbouteFinishAction];
    [HelperClass initLblFooter:self.lblFooter];
    
    [self.lblTitleForSocialShare setFont:[UIFont fontWithName:constFontNautilusPompilius size:12.0f]];
    [self initLblFateAndPlace];
    
    self.vwContainerForMessageAboutFinish.hidden = YES;
    // --------
    //self.imgBannerTop.image = [UIImage imageWithData:[dataModel PosterGetBanner]];
    //self.imgPlaceOfAction.image = [UIImage imageWithData:[dataModel PosterGetBanner]];
}

#pragma mark - Other methods

- (void)initLblMessageAbouteFinishAction
{
    NSString * firstLine = @"Это мероприятие уже закончилось\n";
    NSString * secondLine = @"  но мы обязательно придумаем что-нибудь еще";
    
    NSString * allInfo = [NSString stringWithFormat:@"%@\n%@",firstLine,secondLine];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:allInfo];
    //Range
    NSRange rangeTitle = [allInfo rangeOfString:firstLine];
    NSRange rangeInfo = [allInfo rangeOfString:secondLine];
    //Font
    UIFont * fontTitle = [UIFont fontWithName:constFontFregatBold size:fontSizeMessageFirstLine];
    UIFont * fontInfo = [UIFont fontWithName:constFontNautilusPompilius size:fontSizeMessageSecondLine];
    [attString addAttribute:NSFontAttributeName value:fontTitle range:rangeTitle];
    [attString addAttribute:NSFontAttributeName value:fontInfo range:rangeInfo];
    
    //test
    //[attString addAttribute:NSBackgroundColorAttributeName value:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bannerBig.png"]] range:rangeInfo];
    
    //NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
    //[paragrahStyle setLineSpacing:0.75];
    //[attString addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:rangeTitle];
    //[attString addAttribute:NSBaselineOffsetAttributeName value:@10.0 range:rangeInfo];
    self.lblMessageAboutFinishAction.attributedText = attString;
    //self.lblMessageAboutFinishAction.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bannerBig.png"]];
    //[self.lblMessageAboutFinishAction setContentScaleFactor:0.5];
    //[self.lblMessageAboutFinishAction setAdjustsFontSizeToFitWidth:YES];
    //[self.lblMessageAboutFinishAction setAttributedText:<#(NSAttributedString *)#>];NSForegroundColorAttributeName
}

- (void)initLblFateAndPlace
{
    [self.lblPlaceOfAction setFont:[UIFont fontWithName:constFontNautilusPompilius size:fontSizePlaceOfAction]];
    [self.lblDateOfAction setFont:[UIFont fontWithName:constFontNautilusPompilius size:fontSizeDateOfAction]];
    self.lblDateOfAction.text = @"New position";
    self.lblDateOfAction.minimumScaleFactor = 0.5;
    
    [self.lblDateOfAction setContentScaleFactor:0.5];
    [self.lblDateOfAction setAdjustsFontSizeToFitWidth:YES];
    
    [self.lblPlaceOfAction setContentScaleFactor:0.5];
    [self.lblPlaceOfAction setAdjustsFontSizeToFitWidth:YES];
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
        [self startWorkingWithVK];
    } else {
        [VKSdk authorize:SCOPE revokeAccess:YES];
    }
}

- (void)startWorkingWithVK
{
    VKShareDialogController * shareDialog = [VKShareDialogController new];
    shareDialog.text = @"Your share text here";
    shareDialog.uploadImages = @[[VKUploadImage uploadImageWithImage:[UIImage imageNamed:@"apple"]
                                                           andParams:[VKImageParameters jpegImageWithQuality:0.9]]];
    //shareDialog.otherAttachmentsStrings = @[@"https://vk.com/dev/ios_sdk"];
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
    [self startWorkingWithVK];
}

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)vkSdkAcceptedUserToken:(VKAccessToken *)token {
    [self startWorkingWithVK];
}
- (void)vkSdkUserDeniedAccess:(VKError *)authorizationError {
    [[[UIAlertView alloc] initWithTitle:nil message:@"Access denied" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}

#pragma mark - Share message in social networks

-(IBAction)facebookPost:(id)sender{
    
    SLComposeViewController *controller = [SLComposeViewController
                                           composeViewControllerForServiceType:SLServiceTypeFacebook];
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewControllerCompletionHandler myBlock =
        ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultCancelled)
            {
                NSLog(@"Cancelled");
            }
            else
            {
                NSLog(@"Done");
            }
            [controller dismissViewControllerAnimated:YES completion:nil];
        };
        controller.completionHandler = myBlock;
        //Adding the Text to the facebook post value from iOS
        [controller setInitialText:@"My test post"];
        //Adding the URL to the facebook post value from iOS
        //[controller addURL:[NSURL URLWithString:@"http://www.test.com"]];
        //Adding the Text to the facebook post value from iOS
        [self presentViewController:controller animated:YES completion:nil];
    } else {
        [HelperClass showMessage:@"Facebook integration is not available.  A Facebook account must be set up on your device."  withTitle:@"Error"];
    }
}

-(IBAction)twitterPost:(id)sender{
    /*
     SLComposeViewController *tweetSheet = [SLComposeViewController
     composeViewControllerForServiceType:SLServiceTypeTwitter];
     [tweetSheet setInitialText:@"My test tweet"];
     [self presentViewController:tweetSheet animated:YES completion:nil];
     */
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"My test tweet"];
        [tweetSheet setCompletionHandler:^(SLComposeViewControllerResult result)
         {
             if (result == SLComposeViewControllerResultCancelled)
             {
                 NSLog(@"The user cancelled.");
             }
             else if (result == SLComposeViewControllerResultDone)
             {
                 NSLog(@"The user sent the tweet");
             }
         }];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        [HelperClass showMessage:@"Twitter integration is not available.  A Twitter account must be set up on your device." withTitle:@"Error"];
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
