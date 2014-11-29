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
#import "DataModel.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface UIImage (Helpers)

+ (void) loadFromURL: (NSURL*) url callback:(void (^)(UIImage *image))callback;

@end

@protocol ProtocolUploadDataToCell <NSObject>

@required
- (void)uploadDataToCell:(NSInteger)rowIndex;

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
+ (UIColor*)appPink2Color;

+(NSString*)convertDate:(NSDate*)_date toStringFormat:(NSString*)_stringFormat;

+(void)sheerFacebook:(NSString*)_textSheer image:(UIImage*)_imgSheer forController:(UIViewController*)_controllerCall;
+(void)sheerTwitter:(NSString*)_textSheer image:(UIImage*)_imgSheer forController:(UIViewController*)_controllerCall;


@end
