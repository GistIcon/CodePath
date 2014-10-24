//
//  SettingViewCell.h
//  FacebookDemo
//
//  Created by Siyin Yang on 10/23/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingViewCell;

@protocol SettingViewCellDelegate <NSObject>
    - (void)didChangeSwitch:(SettingViewCell *)settingViewCell;
@end

@interface SettingViewCell : UITableViewCell

    @property (weak, nonatomic) IBOutlet UILabel *cellName;
    @property (weak, nonatomic) IBOutlet UISwitch *cellSwitch;
    @property (weak, nonatomic) id<SettingViewCellDelegate> delegate;
    - (IBAction)switchValueChanged:(id)sender;

@end
