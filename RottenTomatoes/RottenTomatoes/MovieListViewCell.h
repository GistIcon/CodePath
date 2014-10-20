//
//  MovieCellView.h
//  RottenTomatoes
//
//  Created by Siyin Yang on 10/18/14.
//  Copyright (c) 2014 Siyin Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieInfo.h"

@interface MovieListViewCell : UITableViewCell

@property (weak, nonatomic) MovieInfo *movie;
- (UIImage *)getCurrentThumbnailImage;

@end
