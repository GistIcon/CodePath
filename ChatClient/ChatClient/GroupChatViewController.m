//
//  ChatViewController.m
//  ChatClient
//
//  Created by Siyin Yang on 10/29/14.
//  Copyright (c) 2014 Siyin Yang. All rights reserved.
//

#import "GroupChatViewController.h"
#import <Parse/Parse.h>

@interface GroupChatViewController () {
    NSArray *messages;
}
@property (weak, nonatomic) IBOutlet UITableView *messageTable;
@property (weak, nonatomic) IBOutlet UITextField *messageField;

- (IBAction)sendMessage:(id)sender;
@end

@implementation GroupChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.messageTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.messageTable.dataSource = self;
    self.messageTable.delegate = self;
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector: @selector(syncMessages) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    PFObject* message = (PFObject*)messages[indexPath.row];
    cell.textLabel.text = message[@"content"];
    
    return cell;
}


- (IBAction)sendMessage:(id)sender {
    PFObject *message = [PFObject objectWithClassName:@"GroupMessages"];
    message[@"groupName"] = @"WeChatGroupCenter";
    message[@"content"] = self.messageField.text;
    PFUser *currentUser = [PFUser currentUser];
    message[@"fromUserId"] = currentUser[@"username"];
    [message saveInBackground];
}

- (void) syncMessages {
    PFQuery *query = [PFQuery queryWithClassName:@"GroupMessages"];
    [query whereKey:@"groupName" equalTo:@"WeChatGroupCenter"];
    [query orderByAscending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu messages.", objects.count);
            
            messages = objects;
            [self.messageTable reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

@end
