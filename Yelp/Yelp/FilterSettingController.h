//
//  FilterViewController.h
//  Yelp
//
//  Created by Siyin Yang on 10/24/14.
//  Copyright (c) 2014 Siyin Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchFilters.h"

@protocol FilterViewControllerDelegate <NSObject>

- (void)searchWithNewFilters:(SearchFilters *)filters;

@end

@interface FilterSettingController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) SearchFilters *filters;
@property (nonatomic, strong) id <FilterViewControllerDelegate> delegate;

@end

