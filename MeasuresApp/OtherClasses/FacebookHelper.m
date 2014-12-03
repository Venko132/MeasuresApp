//
//  FacebookHelper.m
//  MeasuresApp
//
//  Created by Admin on 02.12.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import "FacebookHelper.h"

@implementation FacebookHelper

+ (FacebookHelper*)sharedHelper
{
    static FacebookHelper * helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[self alloc] init];
    });
    return helper;
}

- (id)init
{
    self = [super init];
    if (self) {
        message = [NSString new];
        image = nil;
    }
    return self;
}

- (void)shareToFB:(NSString*)_message andImage:(UIImage*)_img{
    message = _message;
    image = _img;
    
    if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended)
    {
        [self openShareView];
    } else {
        [FBSession openActiveSessionWithPublishPermissions:@[@"publish_actions"]
                                           defaultAudience:FBSessionDefaultAudienceEveryone
                                           allowLoginUI:YES
                                      completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             
             // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
             [self sessionStateChanged:session state:state error:error];
         }];
    }
}

#pragma mark - Facebook

- (BOOL) checkFacebookPermissions:(FBSession *)session
{
    NSArray *permissions = [session permissions];
    NSArray *requiredPermissions = @[@"publish_actions"];
    
    for (NSString *perm in requiredPermissions) {
        if (![permissions containsObject:perm]) {
            return NO; // required permission not found
        }
    }
    return YES;
}

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    
    // Handle errors
    if (error)
    {
        NSLog(@"Error");
        NSString *alertText;
        NSString *alertTitle;
        // If the error requires people using an app to make an action outside of the app in order to recover
        if ([FBErrorUtility shouldNotifyUserForError:error] == YES){
            alertTitle = @"Something went wrong";
            alertText = [FBErrorUtility userMessageForError:error];
            [HelperClass showMessage:alertText withTitle:alertTitle];
            NSLog(@"%@",alertText);
        } else {
            
            // If the user cancelled login, do nothing
            if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
                NSLog(@"User cancelled login");
                
                // Handle session closures that happen outside of the app
            } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession){
                alertTitle = @"Session Error";
                alertText = @"Your current session is no longer valid. Please log in again.";
                [HelperClass showMessage:alertText withTitle:alertTitle];
                NSLog(@"%@",alertText);
                
                
                // Here we will handle all other errors with a generic error message.
                // We recommend you check our Handling Errors guide for more information
                // https://developers.facebook.com/docs/ios/errors/
            } else {
                //Get more error information from the error
                NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"] objectForKey:@"body"] objectForKey:@"error"];
                
                // Show the user an error message
                alertTitle = @"Something went wrong";
                alertText = [NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact us and mention this error code: %@", [errorInformation objectForKey:@"message"]];
                [HelperClass showMessage:alertText withTitle:alertTitle];
                NSLog(@"%@",alertText);
            }
        }
        // Clear this token
        [FBSession.activeSession closeAndClearTokenInformation];
        return;
    }
    
    if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended)
    {
        if (![self checkFacebookPermissions:FBSession.activeSession]) {
            [self requestPublishPermissions];
        } else {
            [self openShareView];
        }
    }
}

- (void)requestPublishPermissions{
    [FBSession.activeSession requestNewPublishPermissions:[NSArray arrayWithObject:@"publish_actions"]
                                          defaultAudience:FBSessionDefaultAudienceEveryone
                                        completionHandler:^(FBSession *session, NSError *error) {
                                            NSLog(@"reopen");
                                            if (error) {
                                                // Handle new permissions request errors
                                                [self handleRequestPermissionError:error];
                                            } else {
                                                // Make API call
                                                [self openShareView];
                                            }
                                        }];
}

- (void)handleRequestPermissionError:(NSError *)error
{
    NSString * alertTitle;
    NSString * alertText;
    
    if ([FBErrorUtility shouldNotifyUserForError:error] == YES){
        // Error requires people using an app to make an out-of-band action to recover
        alertTitle = @"Something went wrong";
        alertText = [FBErrorUtility userMessageForError:error];
        [HelperClass showMessage:alertText withTitle:alertTitle];
        
    } else {
        // We need to handle the error
        if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
            // Ignore it or...
            alertTitle = @"Permission not granted";
            alertText = @"Your post could not be completed because you didn't grant the necessary permissions.";
            [HelperClass showMessage:alertText withTitle:alertTitle];
            
        } else{
            // All other errors that can happen need retries
            // Show the user a generic error message
            alertTitle = @"Something went wrong";
            alertText = @"Please retry";
            [HelperClass showMessage:alertText withTitle:alertTitle];
        }
    }
}

- (void)openShareView{
   /* NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Sharing Tutorial", @"name",
                                   @"Build great social apps and get more installs.", @"caption",
                                   @"Allow your users to share stories on Facebook from your app using the iOS SDK.", @"description",
                                   @"https://developers.facebook.com/docs/ios/share/", @"link",
                                   @"http://i.imgur.com/g3Qc1HN.png", @"picture",
                                   nil];*/
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:message, @"caption",nil];
    //if(image)
       //[params setObject:image forKey:@"picture"];
    
    // Show the feed dialog
    [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                           parameters:params
                                              handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                  if (error) {
                                                      // An error occurred, we need to handle the error
                                                      // See: https://developers.facebook.com/docs/ios/errors
                                                      NSLog(@"Error publishing story: %@", error.description);
                                                  } else {
                                                      if (result == FBWebDialogResultDialogNotCompleted) {
                                                          // User cancelled.
                                                          NSLog(@"User cancelled.");
                                                      } else {
                                                          // Handle the publish feed callback
                                                          NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                                                          
                                                          if (![urlParams valueForKey:@"post_id"]) {
                                                              // User cancelled.
                                                              NSLog(@"User cancelled.");
                                                              
                                                          } else {
                                                              // User clicked the Share button
                                                              NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                                                              NSLog(@"result %@", result);
                                                          }
                                                      }
                                                  }
                                              }];
}

- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}

@end
