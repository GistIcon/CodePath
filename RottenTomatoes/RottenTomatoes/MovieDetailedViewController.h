//
//  MovieViewController.h
//  RottenTomatoes
//
//  Created by Siyin Yang on 10/18/14.
//  Copyright (c) 2014 Siyin Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieInfo.h"

@interface MovieDetailedViewController : UIViewController

@property (weak, nonatomic) MovieInfo *movie;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil backgroundImage:(UIImage *)backgroundImageOrNil;

@end
