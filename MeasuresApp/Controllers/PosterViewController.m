//
//  PosterViewController.m
//  MeasuresApp
//
//  Created by Admin on 19.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import "PosterViewController.h"
#import <VKSdk.h>

static NSString *const TOKEN_KEY    = @"my_application_access_token";
static NSString *const SHARE_DIALOG = @"Test share dialog";
static NSArray  * SCOPE = nil;

@interface PosterViewController ()<VKSdkDelegate>

@end

@implementation PosterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"Front View", nil);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Share message in social networks

#pragma mark - VK
- (IBAction)shareToVK:(id)sender {
    if(!SCOPE)
        SCOPE = @[VK_PER_FRIENDS, VK_PER_WALL, VK_PER_AUDIO, VK_PER_PHOTOS, VK_PER_NOHTTPS, VK_PER_EMAIL, VK_PER_MESSAGES];
    [VKSdk initializeWithDelegate:self andAppId:@"3974615"];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
