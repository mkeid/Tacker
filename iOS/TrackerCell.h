//
//  TrackerCell.h
//  Tacker
//
//  Created by Mohamed Eid on 11/27/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tracker.h"

@interface TrackerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *unseenLabel;
@property (weak, nonatomic) IBOutlet UILabel *bigUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic) Tracker *tracker;
- (void)setCell:(Tracker *)tracker;
@end
