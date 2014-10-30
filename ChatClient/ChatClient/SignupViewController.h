//
//  SignupViewController.h
//  ChatClient
//
//  Created by Siyin Yang on 10/29/14.
//  Copyright (c) 2014 Siyin Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@protocol SignupViewControllerDelegate <NSObject>
    - (void)signupSuccessful:(PFUser *)user;
@end


@interface SignupViewController : UIViewController
    @property (nonatomic, strong) id <SignupViewControllerDelegate> delegate;
@end
