//
//  FriendshipCell.m
//  Tacker
//
//  Created by Mohamed Eid on 11/27/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "FriendshipCell.h"
#import "FriendsViewController.h"

@implementation FriendshipCell

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
    CALayer *layer = [_editButton layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:3.0];
    
    layer = [_trackerButton layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:3.0];
}

- (void)setCell:(Friendship *)friendship {
    _friendship = friendship;
    
    if(_friendship.name.length > 0 ) {
        _bigUsernameLabel.hidden = YES;
        _nameLabel.hidden = NO;
        _usernameLabel.hidden = NO;
        
        _nameLabel.text = _friendship.name;
        _usernameLabel.text = [NSString stringWithFormat:@"@%@",_friendship.friendedUser.username];
    }
    else {
        _bigUsernameLabel.hidden = NO;
        _nameLabel.hidden = YES;
        _usernameLabel.hidden = YES;
        
        _bigUsernameLabel.text =[NSString stringWithFormat:@"@%@",_friendship.friendedUser.username];
    }
    
    if(friendship.friendedUser.is_pending) {
        [self updateToPendingButton];
    }
}

- (void)updateToPendingButton {
    [_findButton setTitle:@"Pending" forState:UIControlStateNormal];
    [_findButton setBackgroundColor:[UIColor colorWithRed:238/255.0f green:223/255.0f blue:66/255.0f alpha:1.0f]];
    [_findButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _findButton.enabled = NO;
}

- (IBAction)findFriend:(id)sender {
    [_friendship.friendedUser askToTrack:^(BOOL success){
        if(success) {
            _friendship.friendedUser.is_pending = YES;
           [self updateToPendingButton];
        }
    }];
}

- (IBAction)editFriend:(id)sender {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@", self.friendship.friendedUser.username]
                                                      message:[NSString stringWithFormat:@"%@", self.friendship.name]
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:nil];
    message.tag = 0;
    [message addButtonWithTitle:@"Edit Display Name"];
    [message addButtonWithTitle:@"Delete"];
    [message addButtonWithTitle:@"Block"];
    [message show];
}

- (void)editName {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Edit name for @%@", self.friendship.friendedUser.username]
                                                      message:nil
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:nil];
    message.tag = 1;
    [message setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [message textFieldAtIndex:0].text = [NSString stringWithFormat:@"%@", self.friendship.name];
    [message addButtonWithTitle:@"Save"];
    if(_friendship.name && _friendship.name.length > 0)[[message textFieldAtIndex:0] setText:_friendship.name];
    [message show];
}

- (void)deleteFriendship {
    [_friendship destroy:^(BOOL success){
        if(success) {
            [(FriendsViewController *)(MY_APPDELEGATE.tabBarController.viewControllers[2]) orderFriendships];
        }
    }];
}

- (void)blockUser {
    [_friendship.friendedUser block:^(BOOL success){
        if(success) {
            [(FriendsViewController *)(MY_APPDELEGATE.tabBarController.viewControllers[2]) orderFriendships];
        }
    }];
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch(alertView.tag) {
        case 0: // Edit Friendship
            if(buttonIndex == 1) { // selected "Edit Name"
                [self editName];
            }
            else if(buttonIndex == 2) { // selected "Delete"
                [self deleteFriendship];
            }
            else if(buttonIndex == 3) { // selected "Block"
                [self blockUser];
            }
            break;
        case 1: // Edit Name
            if(buttonIndex == 1) { // selected "Save"
                if([alertView textFieldAtIndex:0].text.length > 0) {
                    self.friendship.name = [NSString stringWithFormat:@"%@",[alertView textFieldAtIndex:0].text];
                    [_friendship update:^(BOOL success){
                        if(success) {
                            [(FriendsViewController *)(MY_APPDELEGATE.tabBarController.viewControllers[2]) orderFriendships];
                        }
                    }];
                }
            }
            break;
    }
}

@end
