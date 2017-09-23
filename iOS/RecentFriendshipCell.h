//
//  RecentFriendshipCell.h
//  Tacker
//
//  Created by Mohamed Eid on 12/16/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AddFriendsViewController.h"

@interface RecentFriendshipCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (nonatomic) RecentFriendship *recentFriendship;

- (void)setCell:(RecentFriendship *)recentFriendship;
- (IBAction)alterFriendship:(id)sender;
- (void)alterAddButton;

@end
