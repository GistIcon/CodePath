//
//  Business.m
//  Yelp
//
//  Created by Siyin Yang on 10/24/14.
//  Copyright (c) 2014 Siyin Yang. All rights reserved.
//

#import "YelpItem.h"
#import <MTLValueTransformer.h>

@implementation YelpItem

- (NSString *)reviewCountString
{
    return [NSString stringWithFormat:@"%d Reviews", (int)self.reviewCount];
}

- (NSString *)categoryString
{
    NSString *ret;
    for (NSString *category in self.categories) {
        if (ret == nil) {
            ret = category;
        } else {
            ret = [ret stringByAppendingFormat:@", %@", category];
        }
    }
    return ret;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"imageUrl": @"image_url",
             @"ratingImageUrl": @"rating_img_url_large",
             @"reviewCount": @"review_count",
             @"address": @"location.display_address",
             @"latitude": @"location.coordinate.latitude",
             @"longitude": @"location.coordinate.longitude",
             };
}

+ (NSValueTransformer *)imageUrlJSONTransformer
{
    return [MTLValueTransformer transformerWithBlock:^(NSString *urlString) {
        return [NSURL URLWithString:urlString];
    }];
}

+ (NSValueTransformer *)ratingImageUrlJSONTransformer
{
    return [MTLValueTransformer transformerWithBlock:^(NSString *urlString) {
        return [NSURL URLWithString:urlString];
    }];
}

+ (NSValueTransformer *)addressJSONTransformer
{
    return [MTLValueTransformer transformerWithBlock:^(NSArray *displayAddress) {
        return displayAddress[0];
    }];
}

+ (NSValueTransformer *)categoriesJSONTransformer
{
    return [MTLValueTransformer transformerWithBlock:^(NSArray *categories) {
        NSMutableArray *categoryStrings = [[NSMutableArray alloc] init];
        for (NSArray *category in categories) {
            [categoryStrings addObject:category[0]];
        }
        return categoryStrings;
    }];
}

@end
