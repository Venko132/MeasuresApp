//
//  InstagramViewController.m
//  MeasuresApp
//
//  Created by Admin on 19.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import "InstagramViewController.h"
#import "HelperClass.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface InstagramViewController ()<UIDocumentInteractionControllerDelegate>{
    UIImageView *imageInstagram;
}
@property (nonatomic, strong) UIDocumentInteractionController *documentController;

@end

@implementation InstagramViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - Instagram

-(IBAction)instagramPost:(id)sender
{
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://app"];
    if([[UIApplication sharedApplication] canOpenURL:instagramURL])
    {
        CGFloat cropVal = (imageInstagram.image.size.height > imageInstagram.image.size.width ? imageInstagram.image.size.width : imageInstagram.image.size.height);
        
        cropVal *= [imageInstagram.image scale];
        
        CGRect cropRect = (CGRect){.size.height = cropVal, .size.width = cropVal};
        CGImageRef imageRef = CGImageCreateWithImageInRect([imageInstagram.image CGImage], cropRect);
        
        NSData *imageData = UIImageJPEGRepresentation([UIImage imageWithCGImage:imageRef], 1.0);
        CGImageRelease(imageRef);
        
        NSString *writePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"instagram.igo"];
        if (![imageData writeToFile:writePath atomically:YES]) {
            // failure
            NSLog(@"image save failed to path %@", writePath);
            return;
        } else {
            // success.
        }
        
        // send it to instagram.
        NSURL *fileURL = [NSURL fileURLWithPath:writePath];
        self.documentController = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
        self.documentController.delegate = self;
        [self.documentController setUTI:@"com.instagram.exclusivegram"];
        [self.documentController setAnnotation:@{@"InstagramCaption" : @"We are making fun"}];
        [self.documentController presentOpenInMenuFromRect:self.view.bounds inView:self.view animated:YES];
    }
    else
    {
        [HelperClass showMessage:@"Instagram not installed in this device!\nTo share image please install instagram." withTitle:@"Error"];
        
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
