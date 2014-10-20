//
//  MoviesViewController.m
//  RottenTomatoes
//
//  Created by Siyin Yang on 10/18/14.
//  Copyright (c) 2014 Siyin Yang. All rights reserved.
//

#import "AFNetworking.h"
#import "MBProgressHUD.h"

#import "MoviesListViewController.h"
#import "MovieInfo.h"
#import "MovieListViewCell.h"
#import "MovieDetailedViewController.h"

#define TAB_BOX_OFFICE 0
#define TAB_DVDS 1


@interface MoviesListViewController () {
    NSString *apiKey;
    NSArray *movies;
    UIView *networkErrorView;
    UILabel *networkErrorLabel;
}

@property (strong, nonatomic) MBProgressHUD *progressHUD;
@property (strong, nonatomic) UIRefreshControl *refreshControl;


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

- (void)handleConnectionError:(NSError *)error;
- (void)fetchData:(NSString*)query;

@end

@implementation MoviesListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Movies";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    apiKey = @"9fm6kzedxkm96j9s8zpehpm6";
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchData) forControlEvents:UIControlEventValueChanged];
    
    self.progressHUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    self.progressHUD.mode = MBProgressHUDModeText;
    self.progressHUD.labelText = @"Loading...";
    self.progressHUD.margin = 10.f;
    self.progressHUD.yOffset = -150.f;
    self.progressHUD.removeFromSuperViewOnHide = YES;
    [self.navigationController.view addSubview:self.progressHUD];
    [self.progressHUD showWhileExecuting:@selector(fetchData) onTarget:self withObject:nil animated:YES];
    
    [self.tabBar setSelectedItem:[self.tabBar.items objectAtIndex:0]];
    
    [self fetchData];
    
    self.tableView.rowHeight = 175;
    self.tableView.dataSource = self;
    [self.tableView addSubview:self.refreshControl];
    UINib *movieCellNib = [UINib nibWithNibName:@"MovieTableViewCell" bundle:nil];
    [self.tableView registerNib:movieCellNib forCellReuseIdentifier:@"MovieCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell" forIndexPath:indexPath];
    cell.movie = movies[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MovieListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell" forIndexPath:indexPath];
    cell.movie = movies[indexPath.row];
    MovieDetailedViewController *mvc = [[MovieDetailedViewController alloc]initWithNibName:@"MovieViewController" bundle:nil backgroundImage:[cell getCurrentThumbnailImage]];
    
    // Pass the selected object to the new view controller.
    mvc.movie = movies[indexPath.row];
    
    // Push the view controller.
    [self.navigationController pushViewController:mvc animated:YES];
}

#pragma mark - Private Methods

- (void)handleConnectionError:(NSError *)error {
    
    NSError *underlyingError = [[error userInfo] objectForKey:NSUnderlyingErrorKey];
    
    // configure the error view
    networkErrorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
    networkErrorView.backgroundColor = [UIColor blackColor];
    networkErrorView.alpha = .85;
    
    // configure the error labe
    networkErrorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 300, 150)];
    networkErrorLabel.text = [underlyingError localizedDescription];
    [networkErrorLabel setTextColor:[UIColor whiteColor]];
    [networkErrorLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f]];
    [networkErrorLabel setTextAlignment:NSTextAlignmentCenter];
    
    [networkErrorView addSubview:networkErrorLabel];
    [self.view addSubview:networkErrorView];

}

- (NSString *)getAPI:(NSString*) query {
    if (![query isEqualToString:@""]) {//show movies by default
        return [[[@"http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey="
                  stringByAppendingString:apiKey]
                  stringByAppendingString:@"&q="]
                  stringByAppendingString:[query stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet]];
    }
    
    UITabBarItem *tab = [self.tabBar selectedItem];
    if (tab.tag == TAB_BOX_OFFICE) {
        return [@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=" stringByAppendingString:apiKey];
    }
    else {
        return [@"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=" stringByAppendingString:apiKey];
    }
}


- (void)fetchData {
    [self fetchData:@""];
}

- (void)fetchData:(NSString*) query {
    NSString *url = [self getAPI:query];;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:5.0];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // cleanup any previous network error]
        if ([networkErrorView isDescendantOfView:self.view]) {
            [networkErrorView removeFromSuperview];
        }
        
        movies = [MovieInfo moviesFromArrayOfDictionaries:responseObject[@"movies"]];
        [self.tableView reloadData];
        [self.tableView setHidden:NO];
        [self.progressHUD hide:YES];
        [self.refreshControl endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self handleConnectionError:error];
        [self.progressHUD hide:YES];
        [self.refreshControl endRefreshing];
    }];
    
    [operation start];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    [self fetchData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(fetchData:) withObject:searchText afterDelay:0.5];
}

@end
