//
//  MovieViewController.m
//  RottenTomatoes
//
//  Created by Siyin Yang on 10/18/14.
//  Copyright (c) 2014 Siyin Yang. All rights reserved.
//

#import "MovieDetailedViewController.h"
#import "UIImageView+AFNetworking.h"


@interface MovieDetailedViewController () {
    UIImage *backgroundLoadingImage;
}

@property (weak, nonatomic) IBOutlet UIImageView *movieBackgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieSynopsisLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;


@end

@implementation MovieDetailedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil backgroundImage:(UIImage *)backgroundImageOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        backgroundLoadingImage = backgroundImageOrNil;
    }
    return self;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.scrollView layoutIfNeeded];
    self.scrollView.contentSize = self.contentView.bounds.size;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _movie.title;
    self.movieTitleLabel.text = _movie.title;
    self.movieSynopsisLabel.text = _movie.synopsis;
    [self.movieSynopsisLabel sizeToFit];
    [self.movieBackgroundImageView setImage:backgroundLoadingImage];
    [self.movieBackgroundImageView setImageWithURL:[NSURL URLWithString:_movie.posters[@"original"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
