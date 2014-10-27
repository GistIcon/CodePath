//
//  Business.h
//  Yelp
//
//  Created by Siyin Yang on 10/24/14.
//  Copyright (c) 2014 Siyin Yang. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>

@interface YelpItem : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSURL *imageUrl;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSURL *ratingImageUrl;
@property (nonatomic, readonly) NSInteger reviewCount;
@property (nonatomic, copy, readonly) NSString *address;
@property (nonatomic, copy, readonly) NSArray *categories;
@property (nonatomic, copy, readonly) NSNumber *latitude;
@property (nonatomic, copy, readonly) NSNumber *longitude;

- (NSString *)reviewCountString;
- (NSString *)categoryString;

@end
