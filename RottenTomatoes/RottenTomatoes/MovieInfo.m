//
//  Movie.m
//  RottenTomatoes
//
//  Created by Siyin Yang on 10/18/14.
//  Copyright (c) 2014 Siyin Yang. All rights reserved.
//

#import "MovieInfo.h"

@implementation MovieInfo

- (id)initWithMovieData:(NSDictionary *)movieData {
    self = [super init];
    if (self) {
        _movieId = movieData[@"id"];
        _title = movieData[@"title"];
        _synopsis = movieData[@"synopsis"];
        _posters = movieData[@"posters"];
    }
    return self;
}

+ (NSArray *)moviesFromArrayOfDictionaries:(NSArray *)movieDicts {
    NSArray *movies = [NSArray array];
    for (NSDictionary *movieData in movieDicts) {
        MovieInfo *movie = [[MovieInfo alloc] initWithMovieData:movieData];
        movies = [movies arrayByAddingObject:movie];
    }
    return movies;
}

@end
