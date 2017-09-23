//
//  InviteCell.h
//  Tacker
//
//  Created by Mohamed Eid on 12/20/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddFriendsViewController.h"
#import "Invitee.h"

@interface InviteCell : UITableViewCell
@property (nonatomic) Invitee *invitee;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *inviteButton;

- (void)setCell:(Invitee *)invitee;
- (IBAction)invite:(id)sender;

@end
