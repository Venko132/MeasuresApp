//
//  FacebookHelper.h
//  MeasuresApp
//
//  Created by Admin on 02.12.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>
#import "HelperClass.h"

@interface FacebookHelper : NSObject{
    NSString * message;
    UIImage * image;
}

@property (weak, atomic) UIViewController * delegateContainer;

+ (FacebookHelper*)sharedHelper;
- (void)shareToFB:(NSString*)_message andImage:(UIImage*)_img;

@end
