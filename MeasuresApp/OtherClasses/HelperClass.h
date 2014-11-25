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

//@property (strong, nonatomic) UIColor * appBlueColor;
//@property (strong, nonatomic) UIColor * appPinkColor;

+ (HelperClass*)sharedHelper;
+ (void)showMessage:(NSString*)alertText withTitle:(NSString*)alertTitle;
+ (UIView*)setNavBarTitle:(NSString*)title andWith:(float)_width fontSize:(float)_fontSize;
+ (void)setImageOnNavigationBarForController:(UIViewController*)_controller;
+ (void)initLblFooter:(UILabel*)lblFooter;

+ (UIColor*)appBlueColor;
+ (UIColor*)appPinkColor;
+ (UIColor*)appGrayColor;

@end
