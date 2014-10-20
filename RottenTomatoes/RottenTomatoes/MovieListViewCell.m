//
//  MovieCellView.m
//  RottenTomatoes
//
//  Created by Siyin Yang on 10/18/14.
//  Copyright (c) 2014 Siyin Yang. All rights reserved.
//

#import "MovieListViewCell.h"
#import "UIImageNetworkingUtil.h"

@interface MovieListViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *movieThumbnailImage;
@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieSynopsisLabel;

@end

@implementation MovieListViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setMovie:(MovieInfo *)movie {
    _movie = movie;
    self.movieTitleLabel.text = movie.title;
    self.movieSynopsisLabel.text = movie.synopsis;
    [self.movieThumbnailImage setImageWithURL:[NSURL URLWithString:movie.posters[@"detailed"]] withAnimationDuration:0.5];
}

- (UIImage *)getCurrentThumbnailImage {
    return self.movieThumbnailImage.image;
}

@end
