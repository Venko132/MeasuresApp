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
    UILabel* lblNavTitle = [[UILabel alloc] initWithFrame:CGRectMake(0,0,_width,40)];
    lblNavTitle.textAlignment = NSTextAlignmentLeft;
#warning Set custom color
    lblNavTitle.backgroundColor = [UIColor clearColor];
    lblNavTitle.lineBreakMode = NSLineBreakByWordWrapping;
    lblNavTitle.numberOfLines = 0;
    lblNavTitle.text = title;
    return lblNavTitle;
}

#warning Need upgrate
+ (void)setImageOnNavigationBarForController:(UIViewController*)_controller
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0, 0.0, 70.0, 40.0);
    button.backgroundColor = [UIColor clearColor];
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, -10.0f, 40.0f, 40.0f)];
    img.image = [UIImage imageNamed:@"news.png"];
    [button addSubview:img];
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    _controller.navigationItem.rightBarButtonItem = barButtonItem;
}


@end
