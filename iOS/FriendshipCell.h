//
//  FriendshipCell.h
//  Tacker
//
//  Created by Mohamed Eid on 11/27/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface FriendshipCell : UITableViewCell <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bigUsernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *findButton;
@property (nonatomic) Friendship *friendship;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *trackerButton;

- (void)setCell:(Friendship *)friendship;

- (void)updateToPendingButton;
- (IBAction)findFriend:(id)sender;
- (IBAction)editFriend:(id)sender;
- (void)editName;
- (void)deleteFriendship;
- (void)blockUser;

@end
