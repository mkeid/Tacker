//
//  InviteCell.m
//  Tacker
//
//  Created by Mohamed Eid on 12/20/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "InviteCell.h"

@implementation InviteCell

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
    [_inviteButton setBackgroundColor:[UIColor grayColor]];
    
    AddFriendsViewController *addFriendsViewController = (AddFriendsViewController *)(MY_APPDELEGATE.tabBarController.navigationController.visibleViewController);
    if([addFriendsViewController.numbersToInviteArray containsObject:_invitee.phoneNumber]) {
        [_inviteButton setBackgroundColor:[UIColor colorWithRed:238/255.0f green:223/255.0f blue:66/255.0f alpha:1.0f]];
    }
    
    CALayer *layer = [_inviteButton layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:3.0];
}

- (void)setCell:(Invitee *)invitee {
    _invitee = invitee;
    _nameLabel.text = _invitee.name;
    _phoneNumberLabel.text = [NSString stringWithFormat:@"#%@",_invitee.phoneNumber];
}

- (IBAction)invite:(id)sender {
    if(_inviteButton.backgroundColor == [UIColor grayColor]) {
        [_inviteButton setBackgroundColor:[UIColor colorWithRed:238/255.0f green:223/255.0f blue:66/255.0f alpha:1.0f]];
        AddFriendsViewController *addFriendsViewController = (AddFriendsViewController *)(MY_APPDELEGATE.tabBarController.navigationController.visibleViewController);
        [addFriendsViewController.numbersToInviteArray addObject:_invitee.phoneNumber];
    }
    else {
        [_inviteButton setBackgroundColor:[UIColor grayColor]];
        AddFriendsViewController *addFriendsViewController = (AddFriendsViewController *)(MY_APPDELEGATE.tabBarController.navigationController.visibleViewController);
        [addFriendsViewController.numbersToInviteArray removeObject:_invitee.phoneNumber];
    }

}
@end
