//
//  YelpMapView.h
//  Yelp
//
//  Created by Siyin Yang on 10/24/14.
//  Copyright (c) 2014 Siyin Yang. All rights reserved.
//

#import <GoogleMaps/GoogleMaps.h>
#import "SearchResults.h"

@interface MapView : GMSMapView

@property (nonatomic, copy) SearchResults *searchResults;

@end
