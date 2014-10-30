//
//  LoginViewController.m
//  ChatClient
//
//  Created by Siyin Yang on 10/29/14.
//  Copyright (c) 2014 Siyin Yang. All rights reserved.
//

#import "LoginViewController.h"
#import "GroupChatViewController.h"
#import "SignupViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UILabel *statusMessageLabel;

- (IBAction)signinClick:(id)sender;
- (IBAction)signupClick:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.statusMessageLabel setHidden:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signinClick:(id)sender {
    [self.statusMessageLabel setHidden:true];
    NSString* name = self.nameField.text;
    NSString* password = self.passwordField.text;
    [self login:name:password];
}

- (IBAction)signupClick:(id)sender {
    SignupViewController  *vc = [[SignupViewController alloc] init];
    vc.delegate = self;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];
}

- (void) login: (NSString*)name :(NSString*)password {
    [PFUser logInWithUsernameInBackground:name password:password
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // successful login.
                                            [self loginSuccessful];
                                        } else {
                                            // The login failed.
                                            NSString *errorString = [error userInfo][@"error"];
                                            self.statusMessageLabel.text = errorString;
                                            [self.statusMessageLabel setHidden:false];
                                        }
                                    }];
}

- (void) loginSuccessful {
    GroupChatViewController *vc = [[GroupChatViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];
}

- (void) signupSuccessful:(PFUser *)user {
    self.statusMessageLabel.text = @"Sign up succeeded. Please sign in now.";
    [self.statusMessageLabel setHidden:false];
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
