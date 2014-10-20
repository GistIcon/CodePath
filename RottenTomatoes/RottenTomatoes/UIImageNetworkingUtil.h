#import <UIKit/UIKit.h>

@interface UIImageView (UIImageNetworkingUtil)

- (void)setImageWithURL:(NSURL *)url
                success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image))success
                failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure;

- (void)setImageWithURL:(NSURL *)url withAnimationDuration:(float)animationDuration;

@end
