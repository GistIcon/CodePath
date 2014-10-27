//
//  YelpItemCell.m
//  Yelp
//
//  Created by Siyin Yang on 10/24/14.
//  Copyright (c) 2014 Siyin Yang. All rights reserved.
//

#import "YelpItemCell.h"
#import <UIImageView+AFNetworking.h>

@interface YelpItemCell ()

@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoriesLabel;

@end

@implementation YelpItemCell

- (void)awakeFromNib
{
    // disable selection
    self.userInteractionEnabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setBusiness:(YelpItem *)business
{
    _business = business;
    [self reloadData];
}

- (void)reloadData
{
    self.photoView.image = nil;
    self.ratingImageView.image = nil;

    [self.photoView setImageWithURL:self.business.imageUrl];
    self.titleLabel.text = self.business.name;
    [self.ratingImageView setImageWithURL:self.business.ratingImageUrl];
    self.reviewCountLabel.text = [self.business reviewCountString];
    self.addressLabel.text = self.business.address;
    self.categoriesLabel.text = [self.business categoryString];
}

@end
