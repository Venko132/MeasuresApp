//
//  CYHelperClass.m
//  Unity-iPhone
//
//  Created by Admin on 31.10.14.
//
//

#import "HelperClass.h"

#pragma mark - UIImage (Helpers)

@implementation UIImage (Helpers)

+ (void) loadFromURL: (NSURL*) url callback:(void (^)(UIImage *image))callback {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSData * imageData = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:imageData];
            callback(image);
        });
    });
}

@end

#pragma mark - HelperClass

@implementation HelperClass

+ (HelperClass*)sharedHelper
{
    static HelperClass * helper = nil;
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
        
    }
    return self;
}

+ (void)showMessage:(NSString*)alertText withTitle:(NSString*)alertTitle
{
    [[[UIAlertView alloc] initWithTitle:alertTitle message:alertText
                               delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
}

+ (UIView*)setNavBarTitle:(NSString*)title andWith:(float)_width fontSize:(float)_fontSize{
    CGRect rectOfView = CGRectMake(0,0,_width,40);
    UILabel* lblNavTitle = [[UILabel alloc] initWithFrame:rectOfView];
    lblNavTitle.textAlignment = NSTextAlignmentLeft;
    lblNavTitle.backgroundColor = [UIColor clearColor];
    lblNavTitle.lineBreakMode = NSLineBreakByWordWrapping;
    [lblNavTitle setFont:[UIFont fontWithName:constFontFregatBold size:16.0f]];
    lblNavTitle.numberOfLines = 0;
    lblNavTitle.textColor = [UIColor whiteColor];
    lblNavTitle.adjustsFontSizeToFitWidth=YES;
    lblNavTitle.text = title;
    lblNavTitle.minimumScaleFactor = 0.5;
    
    UIView * vwCustom = [[UIView alloc] initWithFrame:rectOfView];
    [vwCustom addSubview:lblNavTitle];
    
    return vwCustom;
}

+ (void)setImageOnNavigationBarForController:(UIViewController*)_controller
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0, 0.0, 60.0, 40.0);
    button.backgroundColor = [UIColor clearColor];
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, -5.0f, 60.0f, 40.0f)];
    img.image = [UIImage imageNamed:constImagePoster];
    [button addSubview:img];
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    _controller.navigationItem.rightBarButtonItem = barButtonItem;
}

+ (void)initLblFooter:(UILabel*)lblFooter
{
    float fontSize = 9.0f;
    lblFooter.text = constFootterString;
    UIFont * lblFont = [UIFont fontWithName:constFontArial size:fontSize];
    [lblFooter setFont:lblFont];
    lblFooter.numberOfLines = 0;
}

+ (UIColor*)appBlueColor{
    return [UIColor colorWithRed:(56.0f/255.0) green:(61.0f/255.0) blue:(120.0f/255.0) alpha:1.0f];
}
+ (UIColor*)appPinkColor{
    return [UIColor colorWithRed:(204.0f/255.0) green:(126.0f/255.0) blue:(186.0f/255.0) alpha:1.0f];
}

+ (UIColor*)appGrayColor{
    return [UIColor colorWithRed:(135.0f/255.0) green:(135.0f/255.0) blue:(135.0f/255.0) alpha:1.0f];
}

@end
