//
//  Movie.h
//  RottenTomatoes
//
//  Created by Siyin Yang on 10/18/14.
//  Copyright (c) 2014 Siyin Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieInfo : NSObject

@property (nonatomic) NSString *movieId;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *synopsis;
@property (nonatomic) NSDictionary *posters;

- (id)initWithMovieData:(NSDictionary *)movieData;
+ (NSArray *)moviesFromArrayOfDictionaries:(NSArray *)movieDicts;

@end
