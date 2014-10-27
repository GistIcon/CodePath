//
//  SearchResults.h
//  Yelp
//
//  Created by Siyin Yang on 10/24/14.
//  Copyright (c) 2014 Siyin Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResults : NSObject

@property (nonatomic, copy) NSArray *businesses;
@property (nonatomic, copy) NSDictionary *mapRegion;

- (SearchResults *)initWithResponse:(id)response;

@end
