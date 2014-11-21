//
//  DetailNewsViewController.m
//  MeasuresApp
//
//  Created by Admin on 20.11.14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import "DetailNewsViewController.h"
#import "HelperClass.h"

@interface DetailNewsViewController ()

@end

@implementation DetailNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initProperties];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initProperties
{
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:constImageMainMenu]
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(returnToPreview)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    [HelperClass setImageOnNavigationBarForController:self];
    
    self.navigationItem.titleView = [HelperClass setNavBarTitle:constViewTitleNews
                                                        andWith:CGRectGetWidth(self.view.bounds)
                                                       fontSize:12.0f];
}

- (void)returnToPreview
{
    [self.navigationController popViewControllerAnimated:YES];
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
