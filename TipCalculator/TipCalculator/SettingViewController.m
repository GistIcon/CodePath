//
//  SettingViewController.m
//  TipCalculator
//
//  Created by Siyin Yang on 10/14/14.
//  Copyright (c) 2014 Siyin Yang. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

    @property (weak, nonatomic) IBOutlet UISegmentedControl *bgColorControl;
    - (IBAction)updateBgColor:(id)sender;

@end

NSString *const bgColorKey = @"bgColorKey";

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // Loading
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger savedTipValue = [defaults integerForKey:bgColorKey];
    [self.bgColorControl setSelectedSegmentIndex:savedTipValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateBgColor:(id)sender {
    NSInteger bgColor = self.bgColorControl.selectedSegmentIndex;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:bgColor forKey:bgColorKey];
    [defaults synchronize];
}

@end
