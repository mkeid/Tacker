//
//  TrackerCell.m
//  Tacker
//
//  Created by Mohamed Eid on 11/27/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "TrackerCell.h"

@implementation TrackerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    CALayer *layer = [_unseenLabel layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:6.0];
}

- (void)setCell:(Tracker *)tracker {
    _tracker = tracker;
    
    if(tracker.seen) {
        _unseenLabel.hidden = YES;
    }
    
    if(tracker.name.length > 0) {
        _nameLabel.text = _tracker.name;
        _usernameLabel.text = [NSString stringWithFormat:@"@%@",_tracker.tracked_user.username];
        _bigUsernameLabel.hidden = YES;
    }
    else {
        _bigUsernameLabel.text = [NSString stringWithFormat:@"@%@",_tracker.tracked_user.username];
        _nameLabel.hidden = YES;
        _usernameLabel.hidden = YES;
    }
    
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSDate *date = [dateFormat dateFromString:_tracker.updatedAt];
    
    // Convert date object to desired output format
    [dateFormat setDateFormat:@"EEEE \nMMMM dd \nhh:mm a"];
    
    NSTimeZone *tz = [NSTimeZone localTimeZone];
    NSInteger seconds = [tz secondsFromGMTForDate: date];
    NSDate *localDate = [NSDate dateWithTimeInterval: seconds sinceDate:date];
    
    _timeLabel.text = [dateFormat stringFromDate:localDate];
}

@end