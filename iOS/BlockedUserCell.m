//
//  BlockedUserCell.m
//  Tacker
//
//  Created by Mohamed Eid on 11/27/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "BlockedUserCell.h"

@implementation BlockedUserCell

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
    CALayer *layer = [_blockButton layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:3.0];
}

- (void)setCell:(BlockedUser *)blockedUser {
    _blockedUser = blockedUser;
    _nameLabel.text = [NSString stringWithFormat:@"@%@",_blockedUser.user.username];
}

- (void)alterBlockButton {
    if(_blockButton.backgroundColor == [UIColor grayColor]) {
        UIColor * redishColor = [UIColor colorWithRed:255/255.0f green:58/255.0f blue:67/255.0f alpha:1.0f];
        [_blockButton setBackgroundColor:redishColor];
    }
    else {
        [_blockButton setBackgroundColor:[UIColor grayColor]];
    }
}

- (IBAction)alterBlockedUser:(id)sender {
    if(_blockButton.backgroundColor == [UIColor grayColor]) {
        [_blockedUser.user block:^(BOOL success){
            if(success) {
                [self alterBlockButton];
            }
        }];
    }
    else {
        [_blockedUser destroy:^(BOOL success){
            if(success) {
                [self alterBlockButton];
            }
        }];
    }
}

@end
