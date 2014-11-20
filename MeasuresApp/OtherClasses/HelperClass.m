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


@end
