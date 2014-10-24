//
//  SettingViewController.m
//  FacebookDemo
//
//  Created by Siyin Yang on 10/23/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingViewCell.h"

@interface SettingViewController ()
    @property NSInteger selectedSettingIndex;
    @property NSArray *filters;
    @property (weak, nonatomic) IBOutlet UITableView *tableView;
    - (void) onCloseButton;
    - (void) onApplyButton;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.filters = [NSArray arrayWithObjects:
                       @"Home Feed",
                       @"Movies",
                       @"Photos",
                       @"Books",
                       nil];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(onCloseButton)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(onApplyButton)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"SettingViewCell" bundle:nil] forCellReuseIdentifier:@"SettingViewCell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.selectedSettingIndex = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingViewCell"];
    cell.cellName.text = [self.filters objectAtIndex:indexPath.row];
    cell.delegate = self;
    [cell.cellSwitch setOn:(indexPath.row == self.selectedSettingIndex)];
    
    return cell;
}

- (void)didChangeSwitch:(SettingViewCell *)cell {
    self.selectedSettingIndex = [self.tableView indexPathForCell:cell].row;
    [self.tableView reloadData];
}

- (void)onCloseButton {
    NSLog(@"onCloseButton");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onApplyButton {
    NSLog(@"onApplyButton");
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
