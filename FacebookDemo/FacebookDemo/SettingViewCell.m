//
//  SettingViewCell.m
//  FacebookDemo
//
//  Created by Siyin Yang on 10/23/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

#import "SettingViewCell.h"

@implementation SettingViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)switchValueChanged:(id)sender {
    if (self.delegate != nil) {
        [self.delegate didChangeSwitch: self];
    }
}

@end
