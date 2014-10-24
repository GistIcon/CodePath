//
//  NodeCell.h
//  FacebookDemo
//
//  Created by Siyin Yang on 10/23/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NodeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *nodeName;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *statusType;

@end
