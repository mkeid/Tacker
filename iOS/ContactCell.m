//
//  ContactCell.m
//  Tacker
//
//  Created by Mohamed Eid on 12/16/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "ContactCell.h"

@implementation ContactCell

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
    _addButton.backgroundColor = [UIColor grayColor];
    
    CALayer *layer = [_addButton layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:3.0];
}

- (void)setCell:(User *)contact {
    _contact = contact;
    _nameLabel.text = _contact.name;
    _usernameLabel.text = [NSString stringWithFormat:@"@%@",_contact.username];
}

- (void)alterAddButton {
    dispatch_async(dispatch_get_main_queue(), ^{
        if(_addButton.backgroundColor == [UIColor grayColor]) {
            _addButton.backgroundColor = [UIColor colorWithRed:140/255.0f green:198/255.0f blue:43/255.0f alpha:1.0f];
        }
        else {
            _addButton.backgroundColor = [UIColor grayColor];
        }
        
        AddFriendsViewController *addFriendsViewController = (AddFriendsViewController *)MY_APPDELEGATE.tabBarController.navigationController.visibleViewController;
        addFriendsViewController.shouldRefreshRecents = (BOOL *)YES;
    });
}

- (IBAction)alterFriendship:(id)sender {
    if(_addButton.backgroundColor == [UIColor grayColor]) {
        [_contact friend:^(BOOL success) {
            if(success) {
                [self alterAddButton];
            }
        }];
    }
    else {
        [_contact unfriend:^(BOOL success) {
            if(success) {
                [self alterAddButton];
            }
        }];
    }
}
@end
