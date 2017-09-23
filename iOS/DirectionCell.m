//
//  DirectionCell.m
//  Tacker
//
//  Created by Mohamed Eid on 12/26/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "DirectionCell.h"

@implementation DirectionCell

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
    CALayer *layer = [_stepCountLabel layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:10.0];
}

@end
