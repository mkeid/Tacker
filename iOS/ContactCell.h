//
//  ContactCell.h
//  Tacker
//
//  Created by Mohamed Eid on 12/16/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AddFriendsViewController.h"

@interface ContactCell : UITableViewCell
@property (nonatomic) User *contact;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

- (void)setCell:(User *)contact;
- (IBAction)alterFriendship:(id)sender;

@end
