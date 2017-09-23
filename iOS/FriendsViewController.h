//
//  FriendsViewController.h
//  Tacker
//
//  Created by Mohamed Eid on 11/19/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AddFriendsViewController.h"
#import "BlockedUsersViewController.h"
#import "FriendshipCell.h"
#import "MeCell.h"

@interface FriendsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *alphabetArray;
@property (nonatomic) NSMutableDictionary *alphabetDictionary;
@property (nonatomic) NSMutableDictionary *orderedFriendships;
@property (nonatomic, copy) UIRefreshControl *refreshControl;

- (void)orderFriendships;
- (IBAction)loadBlockedUsersViewController:(id)sender;
- (IBAction)loadAddFriendsViewController:(id)sender;

@end
