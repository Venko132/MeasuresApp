//
//  CYHelperClass.h
//  Unity-iPhone
//
//  Created by Admin on 31.10.14.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ConstantsClass.h"

@interface UIImage (Helpers)

+ (void) loadFromURL: (NSURL*) url callback:(void (^)(UIImage *image))callback;

@end

@interface HelperClass : NSObject


+ (HelperClass*)sharedHelper;
+ (void)showMessage:(NSString*)alertText withTitle:(NSString*)alertTitle;
+ (UIView*)setNavBarTitle:(NSString*)title andWith:(float)_width fontSize:(float)_fontSize;
+ (void)setImageOnNavigationBarForController:(UIViewController*)_controller;

@end
