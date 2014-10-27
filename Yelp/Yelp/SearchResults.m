//
//  SearchResults.m
//  Yelp
//
//  Created by Siyin Yang on 10/24/14.
//  Copyright (c) 2014 Siyin Yang. All rights reserved.
//

#import "SearchResults.h"
#import "YelpItem.h"
#import <MTLJSONAdapter.h>

@implementation SearchResults

- (SearchResults *)initWithResponse:(id)response
{
    self = [super init];
    if (self) {
        self.businesses = [MTLJSONAdapter modelsOfClass:YelpItem.class fromJSONArray:response[@"businesses"] error:nil];
        self.mapRegion = response[@"region"];
    }
    return self;
}

@end
