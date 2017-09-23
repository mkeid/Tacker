//
//  RecentFriendshipCell.m
//  Tacker
//
//  Created by Mohamed Eid on 12/16/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "RecentFriendshipCell.h"

@implementation RecentFriendshipCell

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
    CALayer *layer = [_addButton layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:3.0];
}

- (void)setCell:(RecentFriendship *)recentFriendship {
    self.recentFriendship = recentFriendship;
    
    if(_recentFriendship.name.length > 0) {
       _nameLabel.text = [NSString stringWithFormat:@"%@",self.recentFriendship.name];
    }
    else {
       _nameLabel.text = [NSString stringWithFormat:@"@%@",self.recentFriendship.friendingUser.username];
    }
    
    if(_recentFriendship.friendingUser.is_friended) {
        _addButton.backgroundColor = [UIColor colorWithRed:140/255.0f green:198/255.0f blue:43/255.0f alpha:1.0f];
    }
    else {
        _addButton.backgroundColor = [UIColor grayColor];
    }
}

- (void)alterAddButton {
    if(_addButton.backgroundColor == [UIColor grayColor]) {
        _addButton.backgroundColor = [UIColor colorWithRed:140/255.0f green:198/255.0f blue:43/255.0f alpha:1.0f];
    }
    else {
        _addButton.backgroundColor = [UIColor grayColor];
    }
    AddFriendsViewController *addFriendsViewController = (AddFriendsViewController *)MY_APPDELEGATE.tabBarController.navigationController.visibleViewController;
    addFriendsViewController.shouldRefreshContacts = (BOOL *)YES;
}

- (IBAction)alterFriendship:(id)sender {
    if(self.recentFriendship.friendingUser.is_friended) {
        [_recentFriendship.friendingUser unfriend:^(BOOL success) {
            if(success) {
                _recentFriendship.friendingUser.is_friended = NO;
                [self alterAddButton];
            }
        }];
    }
    else {
        [_recentFriendship.friendingUser friend:^(BOOL success) {
            if(success) {
                _recentFriendship.friendingUser.is_friended = YES;
                [self alterAddButton];
            }
        }];
    }
}
@end
