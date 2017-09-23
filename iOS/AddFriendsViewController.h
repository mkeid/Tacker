//
//  AddFriendsViewController.h
//  Tacker
//
//  Created by Mohamed Eid on 11/19/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "AppDelegate.h"

@interface AddFriendsViewController : UIViewController <UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *contactsTableView;
@property (weak, nonatomic) IBOutlet UITableView *recentTableView;
@property (weak, nonatomic) IBOutlet UIView *usernameView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
@property (weak, nonatomic) IBOutlet UITabBarItem *contactsTabItem;
@property (weak, nonatomic) IBOutlet UITabBarItem *recentTabItem;
@property (weak, nonatomic) IBOutlet UITabBarItem *usernameTabItem;
@property (weak, nonatomic) IBOutlet UIButton *addFriendButton;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshButtonItem;

@property (nonatomic) NSMutableArray *numbersToInviteArray;
@property (nonatomic) NSMutableArray *allPhoneNumbers;

@property (nonatomic) BOOL *shouldRefreshContacts;
@property (nonatomic) BOOL *shouldRefreshRecents;


- (void)showContacts;
- (void)showRecent;
- (void)showUsername;
- (IBAction)addFriend:(id)sender;
- (IBAction)dismissViewController:(id)sender;
- (IBAction)refresh:(id)sender;
- (void)grayOutInviteButtons;
- (void)sendInAppSMS;

- (void)populateContacts;
- (void)refreshRecentAdds;
- (void)setTackerUsersFromMyContacts;

@end
