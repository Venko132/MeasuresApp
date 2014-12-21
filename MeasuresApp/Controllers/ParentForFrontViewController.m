//
//  ParentFrontViewController.m
//  MeasuresApp
//
//  Created by Admin on 19.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import "ParentForFrontViewController.h"

@interface ParentForFrontViewController ()

@end

@implementation ParentForFrontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSideBare];
    [HelperClass setImageOnNavigationBarForController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSideBare
{
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    [self.navigationController.navigationBar setTranslucent:NO];
    /*
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:constImageMainMenu]
                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    */
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0, 0.0, 24.0, 23.0);
    button.backgroundColor = [UIColor clearColor];
    UIImage * btnImage = [UIImage imageNamed:constImageMainMenu];
    [button addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:btnImage forState:UIControlStateNormal];
    [button setBackgroundImage:btnImage forState:UIControlStateHighlighted];
    
    UIBarButtonItem* revealButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
}

@end
