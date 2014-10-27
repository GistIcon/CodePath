//
//  YelpMapView.m
//  Yelp
//
//  Created by Siyin Yang on 10/24/14.
//  Copyright (c) 2014 Siyin Yang. All rights reserved.
//

#import "MapView.h"
#import "YelpItem.h"

@implementation MapView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.myLocationEnabled = YES;
    }
    return self;
}

- (void)setSearchResults:(SearchResults *)searchResults
{
    _searchResults = searchResults;
    [self reloadData];
}

- (void)reloadData
{
    // clear all existing markers
    [self clear];

    // reset the viewport of the map
    NSDictionary *mapCenter = self.searchResults.mapRegion[@"center"];
    double latitude = [mapCenter[@"latitude"] doubleValue];
    double longitude = [mapCenter[@"longitude"] doubleValue];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                            longitude:longitude
                                                                 zoom:12];
    self.camera = camera;

    // add a marker for each business
    for (YelpItem *business in self.searchResults.businesses) {
        [self addMarkerForBusiness:business];
    }
}

- (void)addMarkerForBusiness:(YelpItem *)business
{
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake([business.latitude doubleValue], [business.longitude doubleValue]);
    marker.title = business.name;
    marker.snippet = business.address;
    marker.map = self;
}

@end
