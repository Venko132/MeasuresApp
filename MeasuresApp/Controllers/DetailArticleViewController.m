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
#import <Social/Social.h>

static NSString *const TOKEN_KEY    = @"my_application_access_token";
static NSString *const SHARE_DIALOG = @"Test share dialog";
static NSArray  * SCOPE = nil;
//static NSString *const VKApiID      = @"4642356";

@interface DetailArticleViewController (){
    DataModel * dataModel;
}

//@property (assign, nonatomic) float heigthLblTitleStart;
@property (assign, nonatomic) float posYLblTitleStartMax;

@end

//Phone
static float const fontSizeDatePhone = 12.0f;
static float const fontSizeInfoPhone = 12.0f;
static float const fontSizeInfoSubtitlePhone = 10.0f;
static float const fontSizeInfoTitlePhone = 18.0f;

//Pad
static float const fontSizeDatePad = 24.0f;
static float const fontSizeInfoPad = 24.0f;
static float const fontSizeInfoSubtitlePad = 20.0f;
static float const fontSizeInfoTitlePad = 36.0f;

static NSString * const strHtmlTagH1 = @"<h1>";
static NSString * const strHtmlTagSpan = @"</span>";
static NSString * const strHtmlTagP = @"<p>";

@implementation DetailArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initProperties];
    [self setInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated
{
   // [self viewDidAppear:animated];
    //[self.tblArticle reloadData];
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
    [self setBackButton];
    
    dataModel = [DataModel Instance];
    
    [HelperClass initLblFooter:self.lblFooter];
    [self chooseContainerForInfo];
}

- (void)returnToPreview
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableView delegate

- (void)setInfo{
    [self.lblDate setFont:[UIFont fontWithName:constFontNautilusPompilius size:[[HelperClass sharedHelper] selectSizePhone:fontSizeDatePhone andSizePad:fontSizeDatePad]]];
    self.lblDate.textColor = [HelperClass appGrayColor];
    
    self.lblTitle.textColor = [HelperClass appPink2Color];
    [self.lblTitle setFont:[UIFont fontWithName:constFontFregatBold size:[[HelperClass sharedHelper] selectSizePhone:fontSizeInfoTitlePhone andSizePad:fontSizeInfoTitlePad]]];
    
    [self.txtVwInfo setFont:[UIFont fontWithName:constFontArial size:[[HelperClass sharedHelper] selectSizePhone:fontSizeInfoSubtitlePhone andSizePad:fontSizeInfoSubtitlePad]]];
    
    [self.lblTitleForSocialShare setFont:[UIFont fontWithName:constFontNautilusPompilius size:[[HelperClass sharedHelper] selectSizePhone:12.0f andSizePad:24.0f]]];

    // set Info
    self.lblDate.text = [HelperClass convertDate:self.articleDate toStringFormat:@"dd MMMM yyyy"];
    
    if(self.articleAvatar)
        self.imgAvatar.image = self.articleAvatar;
    
    self.articleSubtitle = [[self.articleSubtitle stringByConvertingHTMLToPlainText]  stringByDecodingHTMLEntities];
    self.lblTitle.attributedText = [self setTitle:self.articleTitle
                                          andInfo:self.articleSubtitle];
    self.posYLblTitleStartMax = CGRectGetMaxY(self.lblTitle.frame);
    [self.lblTitle sizeToFit];
    
    [self calculationOfPosYLblTitle];
    [self setNewPositionOfTxtVw];
    
}

- (NSMutableAttributedString*)setTitle:(NSString*)_titleS andInfo:(NSString*)_infoS
{
    if(!_titleS && !_infoS){
        NSMutableAttributedString * str =[[NSMutableAttributedString alloc] initWithString: @" "];
        return str;
    }
    if(!_titleS)
        _titleS = @" ";
    if(!_infoS)
        _infoS = @" ";
    
    NSString * allInfo = [NSString stringWithFormat:@"%@\n%@",_titleS,_infoS];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:allInfo];
    //Range
    NSRange rangeTitle = [allInfo rangeOfString:_titleS];
    NSRange rangeInfo = [allInfo rangeOfString:_infoS options:NSBackwardsSearch];
    
    //Font
    UIFont * fontTitle = [UIFont fontWithName:constFontFregatBold size:[[HelperClass sharedHelper] selectSizePhone:fontSizeInfoTitlePhone andSizePad:fontSizeInfoTitlePad]];
    UIFont * fontInfo = [UIFont fontWithName:constFontArial size:[[HelperClass sharedHelper] selectSizePhone:fontSizeInfoPhone andSizePad:fontSizeInfoPad]];
    //Color
    if(rangeTitle.location != NSNotFound){
        [attString addAttribute:NSForegroundColorAttributeName value:[HelperClass appPink2Color] range:rangeTitle];
        [attString addAttribute:NSFontAttributeName value:fontTitle range:rangeTitle];
    }
    if(rangeInfo.location != NSNotFound){
        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:rangeInfo];
        [attString addAttribute:NSFontAttributeName value:fontInfo range:rangeInfo];
    }
    
    return attString;
    
}

- (void)setBackButton{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0, 0.0, 24.0, 23.0);
    button.backgroundColor = [UIColor clearColor];
    UIImage * btnImage = [UIImage imageNamed:constImageMainMenu];
    [button addTarget:self action:@selector(returnToPreview) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:btnImage forState:UIControlStateNormal];
    [button setBackgroundImage:btnImage forState:UIControlStateHighlighted];
    
    UIBarButtonItem* revealButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
}

- (void)calculationOfPosYLblTitle
{
    if(!self.articleDate){
        self.lblDate.text = @"";
    
        CGRect lblTitleRect = self.lblTitle.frame;
        lblTitleRect.origin.y = CGRectGetMinY(self.lblDate.frame) +10.0f;
        self.lblTitle.frame = lblTitleRect;
    }
}

- (float)calculationOfPosYTxtInfo
{
    float dif = 0;
    if(self.posYLblTitleStartMax >= CGRectGetMaxY(self.lblTitle.frame))
        dif = 0;
    else {
        dif = CGRectGetMaxY(self.lblTitle.frame) - self.posYLblTitleStartMax;
    }
    return dif;
}

- (void)setNewPositionOfTxtVw
{
    CGRect frameInfo = self.txtVwInfo.frame;
    float dif = [self calculationOfPosYTxtInfo];
    if(dif != 0){
        frameInfo.origin.y += dif;
        frameInfo.size.height -= dif;
        self.txtVwInfo.frame = frameInfo;
        self.wbVwInfo.frame = frameInfo;
    }
}

- (void)chooseContainerForInfo
{
    if(self.articleInfo){
        NSRange rangeH1 = [self.articleInfo rangeOfString:strHtmlTagH1 options:(NSCaseInsensitiveSearch)];
        NSRange rangeSpan = [self.articleInfo rangeOfString:strHtmlTagSpan options:(NSCaseInsensitiveSearch)];
        NSRange rangeP = [self.articleInfo rangeOfString:strHtmlTagP options:(NSCaseInsensitiveSearch)];
        BOOL isHaveHtmlContent = NO;
        if((rangeH1.location != NSNotFound) || (rangeSpan.location != NSNotFound)|| (rangeP.location != NSNotFound)){
            isHaveHtmlContent = YES;
            
            [self.wbVwInfo loadHTMLString:self.articleInfo baseURL:nil];
        } else
            self.txtVwInfo.text = self.articleInfo;
        
        self.txtVwInfo.hidden = isHaveHtmlContent;
        self.wbVwInfo.hidden = !isHaveHtmlContent;
        
    } else {
        self.txtVwInfo.hidden = YES;
        self.wbVwInfo.hidden = YES;
    }
}

#pragma mark - WebView delegate

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
    shareDialog.text = self.articleTitle;
    if(self.articleAvatar)
        shareDialog.uploadImages = @[[VKUploadImage uploadImageWithImage:self.articleAvatar
                                                           andParams:[VKImageParameters jpegImageWithQuality:0.9]]];
    if(self.articleLink && (self.articleLink.length > 0))
        shareDialog.otherAttachmentsStrings = @[self.articleLink];
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
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self startWorkingWithVK];
    }];
}

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)vkSdkAcceptedUserToken:(VKAccessToken *)token {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self startWorkingWithVK];
    }];
}
- (void)vkSdkUserDeniedAccess:(VKError *)authorizationError {
    [[[UIAlertView alloc] initWithTitle:nil message:@"Access denied" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}

#pragma mark - Share message in social networks

-(IBAction)facebookPost:(id)sender{
    [[HelperClass sharedHelper] shareFacebook:self.articleTitle
                              andDescrioption:self.articleSubtitle
                                        image:self.articleAvatar
                                forController:self
                                    andImgUrl:self.articleUrlImage
                                      andLink:self.articleLink];
}

-(IBAction)twitterPost:(id)sender{
    
    [[HelperClass sharedHelper] shareTwitter:self.articleTitle
                             andDescrioption:self.articleSubtitle
                                       image:self.articleAvatar
                               forController:self
                                   andImgUrl:self.articleUrlImage
                                     andLink:self.articleLink];
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
